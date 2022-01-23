module Services
  module Authorization
    class Authorize
      AUTHORIZE_USERS_GROUP  = %w[admin].freeze
      def call(message: nil)
        return false if message.blank?

        @app_suers = find_users

        return false unless @app_suers

        user_token = "#{message.chat.id}_#{message.chat.first_name}"

        authorize(user_token)
      end

      private

      def find_users
        Database::UsersModels.where(actions: AUTHORIZE_USERS_GROUP)
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
