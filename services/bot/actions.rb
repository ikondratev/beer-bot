module Services
  module Bot
    class Actions
      def initialize(actions)
        @actions = actions
      end

      def call(message:)
        nil
      end
    end
  end
end