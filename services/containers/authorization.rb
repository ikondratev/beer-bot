module Services
  module Containers
    class Authorization
      AUTHORIZE_USERS_GROUP  = %w[admin].freeze
      def call(message: nil)
        return false if message.blank?

        @app_suers = find_users

        return false unless @app_suers

        user_token = generate_token(message)

        authorize(user_token)
      rescue StandardError => e
        raise Services::Errors::DBConnectionError.new(e.message)
      end

      private

      def find_users
        Database::UsersModels.where(actions: AUTHORIZE_USERS_GROUP)
      end

      def generate_token(message)
        params = { chat_id: message.chat.id, first_name:  message.chat.first_name }

        Database::UsersModels.generate_token(params)
      end

      def authorize(user_token)
        return false if user_token.blank?

        @app_suers.any? do |user|
          user.token == user_token
        end
      end
    end
  end
end