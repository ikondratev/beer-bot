require_relative '../../../database/connection'

module Services
  module Bot
    module Functions
      class AddUser
        def call(message: nil, params: nil)
          create_user(message, params)
        end

        private

        def create_user(message, params)
          user_params = prepare_params(message, params)
          user = Database::UsersModels.new
          user.id = Database::UsersModels.generate_id
          user.token = Database::UsersModels.generate_token(user_params)
          user.name = user_params[:name]
          user.email = user_params[:email]
          user.save
        end

        def prepare_params(message, params)
          { chat_id:    message.chat.id,
            first_name: "test",
            email:      "last_test"
          }
        end
      end
    end
  end
end
