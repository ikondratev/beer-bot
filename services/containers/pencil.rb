module Services
  module Containers
    class Pencil
      PENCIL_ANSCVER = " у тебя в штанах".freeze
      def call(message:)
        send_pencil_message(message)
      end

      private

      def send_pencil_message(message)
        "#{message.text} #{PENCIL_ANSCVER}"
      end
    end
  end
end
