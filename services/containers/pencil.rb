module Services
  module Containers
    class Pencil
      PENCIL_ANSWER = " у тебя в штанах".freeze
      def call(message:)
        send_pencil_message(message)
      end

      private

      def send_pencil_message(message)
        "#{message.text} #{PENCIL_ANSWER}"
      end
    end
  end
end
