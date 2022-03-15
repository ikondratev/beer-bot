module Services
  module Bot
    class Base
      include Config::Load::Containers

      def initialize(env: environment, logger: nil)
        @token = env.store(value: "token")
        @bot_actions = Constants::Inner::BOT_ACTIONS
        @logger = logger
        initialize_containers
      end

      protected

      def start; end
    end
  end
end