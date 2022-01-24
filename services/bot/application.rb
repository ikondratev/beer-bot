require 'telegram/bot'
require './config/load/containers'
require './constants/inner'

module Services
  module Bot
    class Application
      include Config::Load::Containers
      NOT_CONFIRMED = "Actions is not confirmed".freeze
      NOT_AUTHORIZE = "Sorry! You are haven't any rules".freeze

      def initialize(env: environment)
        @token = env.store(value: "token")
        @bot_actions = Constants::Inner::BOT_ACTIONS
        initialize_containers
      end

      def start
        Telegram::Bot::Client.run(@token) do |bot|
          bot.listen do |message|
            params = message.text.split(" ")
            action = params.first

            next send_message(bot, message, { text: NOT_AUTHORIZE }) unless user_authorize(message)

            if @bot_actions.include?(action)
              response = actions_container!.call(message: message, action: action, params: params.drop(1))
            else
              response = { text: NOT_CONFIRMED }
            end

            send_message(bot, message, response)
          end
        end
      end

      private

      def user_authorize(message)
        authorization_container!.call(message: message)
      end

      def send_message(bot, message, response)
        bot.api.send_message(chat_id: message.chat.id, text: response[:text])
      end
    end
  end
end