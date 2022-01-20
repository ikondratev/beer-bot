require './services/bot/functions/add_user'

module Services
  module Bot
    class Actions

      def call(message:)
        response = store_message(message)
        prepare_response(response)
      end

      private

      def store_message(message)
        case message.text
        when "/hello"    then "Hello #{message.from.first_name}"
        when "/start"    then "Let's start #{message.from.first_name}"
        when "/stop"     then "Buy #{message.from.first_name}"
        when "/add_user" then add_user(message)
        else  "Unidentified action #{message.from.first_name}"
        end
      end

      def add_user(message)
        Services::Bot::Functions::AddUser.new.call(user: message.text)
      end

      def prepare_response(text)
        { text: text }
      end
    end
  end
end