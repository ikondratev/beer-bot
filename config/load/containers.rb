module Config
  module Load
    module Containers
      def initialize_containers
        container = Dry::Container.new
        container.register(:actions, Services::Containers::Action.new)
        container.register(:authorization, Services::Containers::Authorization.new)
        container.register(:pencil, Services::Containers::Pencil.new)
        container.register(:logger, Services::Log::BotLog.new.logger)
        @actions_container = container.resolve(:actions)
        @authorization_container = container.resolve(:authorization)
        @pencil_container = container.resolve(:pencil)
        @logger = container.resolve(:logger)
      end
    end
  end
end
