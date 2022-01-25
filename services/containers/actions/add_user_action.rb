require_relative '../../../database/connection'

module Services
  module Containers
    module Actions
      class AddUserAction
        def call(params: nil)
          return false if params.empty?

          create_user(params)
        end

        private

        def create_user(params)
          user_params = prepare_params(params)
          user         = Database::UsersModels.new
          user.id      = Database::UsersModels.generate_id
          user.token   = Database::UsersModels.generate_token(user_params)
          user.name    = user_params[:name]
          user.actions = user_params[:actions]
          user.email   = user_params[:email]

          raise "Not uniq user" if Database::UsersModels.not_unique_user?(user)

          user.save
          "Successful added user #{user.email}"
        rescue => e
          "Fail: #{e.message}"
        end

        def prepare_params(params)
          { first_name: params[0],
            email:      params[1],
            actions:    params[2] || "admin",
            chat_id:    params[3] || "" }
        end
      end
    end
  end
end
