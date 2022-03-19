require 'telegram/bot'
require './config/load/containers'
require './constants/inner'
require './services/errors/backend_error'

module Services
  module Bot
    class Application
      include Config::Load::Containers

      def initialize(env: environment, logger: nil)
        @token = env.store(value: "token")
        @bot_actions = Constants::Inner::BOT_ACTIONS
        @logger = logger
        initialize_containers
      end

      def start
        Telegram::Bot::Client.run(@token) do |bot|
          bot.listen do |message|
            params = message.text.split(" ")
            action = params.first

            next send_message(
              bot,
              message,
              { text: Constants::Inner::NOT_AUTHORIZE }
            ) unless user_authorize(message)

            response = if @bot_actions.include?(action)
                         actions_container!.call(message: message, action: action, params: params.drop(1))
                       else
                         { text: pencil_container!.call(message: message) }
                       end

            send_message(bot, message, response)
          rescue Services::Errors::BackendError => e
            @logger.error(e.message)

            next send_message(bot, message, { text: Constants::Inner::BACKEND_ERROR })
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
