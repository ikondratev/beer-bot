require_relative '../../../database/connection'

module Services
  module Containers
    module Actions
      class AddUserAction
        def call(message: nil, params: nil)
          return false if params.empty?

          create_user(message, params)
        end

        private

        def create_user(message, params)
          user_params = prepare_params(message, params)
          user = Database::UsersModels.new
          user.id = Database::UsersModels.generate_id
          user.token = Database::UsersModels.generate_token(user_params)
          user.name    = user_params[:name]
          user.actions = user_params[:actions]
          user.email   = user_params[:email]
          user.save

          "Successful added user #{user.email}"
        rescue => e
          "Fail: #{e.message}"
        end

        def prepare_params(message, params)
          { chat_id:    message.chat.id,
            first_name: params[0],
            email:      params[1],
            actions:    params[2] || "admin" }
        end
      end
    end
  end
end
