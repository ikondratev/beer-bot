require './services/bot/functions/add_user'

module Services
  module Bot
    class Actions
      def call(message: nil, action: nil, params: nil)
        response = store_message(message, action, params)
        prepare_response(response)
      end

      private

      def store_message(message, action, params)
        case action
        when "/hello"    then "Hello #{message.from.first_name}"
        when "/start"    then "Let's start #{message.from.first_name}"
        when "/stop"     then "Buy #{message.from.first_name}"
        when "/add_user" then add_user(message, params)
        else  "Unidentified action #{message.from.first_name}"
        end
      end

      def add_user(message, params)
        Services::Bot::Functions::AddUser.new.call(message: message, params: params)
      end

      def prepare_response(text)
        { text: text }
      end
    end
  end
end