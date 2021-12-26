require 'telegram/bot'
require './config/load/containers'
require './constants/inner'
require_relative '../../database/connection'

module Services
  module Bot
    class Application
      include Config::Load::Containers
      USERS_ACTION  = "admin".freeze
      NOT_CONFIRMED = "Actions is not confirmed".freeze
      NOT_AUTHORIZE = "Sorry! You are haven't any rules".freeze

      def initialize(token:, base_params:)
        Database::Connection.instance.adapter(connection_params: base_params)
        @users = Database::UsersModels.where(actions:USERS_ACTION)
        @token = token
        @bot_actions = Constants::Inner::BOT_ACTIONS
        initialize_containers
      end

      def start
        Telegram::Bot::Client.run(@token) do |bot|
          bot.listen do |message|
            next send_message(bot, message, { text: NOT_AUTHORIZE }) unless authorize_users(message)

            if @bot_actions.include?(message.text)
              response = actions_container!.call(message: message)
            else
              response = { text: NOT_CONFIRMED }
            end

            send_message(bot, message, response)
          end
        end
      end

      private

      def send_message(bot, message, response)
        bot.api.send_message(chat_id: message.chat.id, text: response[:text])
      end

      def authorize_users(message)
        return false if message.blank?

        token = "#{message.chat.id}_#{message.chat.first_name}"

        return false if @users.empty?

        @users.any? do |user|
          user.token == token
        end
      end
    end
  end
end