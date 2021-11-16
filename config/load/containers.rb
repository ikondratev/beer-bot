require 'dry/system/container'
require './services/bot/actions'

module Config
  module Load
    module Containers
      def initialize_containers
        container = Dry::Container.new
        container.register(:action, Services::Bot::Actions.new)
        @actions_container = container.resolve(:action)
      end

      def actions_container!
        @actions_container
      end
    end
  end
end