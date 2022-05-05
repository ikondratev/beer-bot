module Services
  module Bot
    class Application
      def initialize(env: environment)
        @token = env.store(value: "token")
        @bot_actions = Constants::BOT_ACTIONS
      end

      def start
        Telegram::Bot::Client.run(@token) do |bot|
          bot.listen do |message|
            params = message.text.split(" ")
            action = params.first

            next send_message(bot, message, { text: Constants::NOT_AUTHORIZE }) unless user_authorize(message)

            response = if @bot_actions.include?(action)
                         Thread.current[:actions].call(message: message, action: action, params: params.drop(1))
                       else
                         { text: Thread.current[:pencil].call(message: message) }
                       end

            send_message(bot, message, response)
          rescue Services::Errors::BackendError => e
            Thread.current[:logger].error("[#{self.class}]: #{e.message}")

            next send_message(bot, message, { text: Constants::BACKEND_ERROR })
          end
        end
      end

      private

      def user_authorize(message)
        Thread.current[:authorization].call(message: message)
      end

      def send_message(bot, message, response)
        bot.api.send_message(chat_id: message.chat.id, text: response[:text])
      end
    end
  end
end
