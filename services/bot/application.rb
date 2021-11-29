require 'telegram/bot'
require './config/load/containers'
require './constants/inner'

module Services
  module Bot
    class Application
      include Config::Load::Containers

      def initialize(token:)
        @token = token
        @bot_actions = Constants::Inner::BOT_ACTIONS
        initialize_containers
      end

      def start
        Telegram::Bot::Client.run(@token) do |bot|
          bot.listen do |message|
            if @bot_actions.include?(message.text)
              response = actions_container!.call(message: message)
              bot.api.send_message(response)
            else
              bot.api.send_message(chat_id: message.chat.id, text: "Actions is not confirmed")
            end
          end
        end
      end
    end
  end
end