require 'dry/system/container'
require './services/bot/actions'
require './services/authorization/authorize'

module Config
  module Load
    module Containers
      def initialize_containers
        container = Dry::Container.new
        container.register(:action, Services::Bot::Actions.new)
        container.register(:authorization, Services::Authorization::Authorize.new)
        @actions_container = container.resolve(:action)
        @authorization_container = container.resolve(:authorization)
      end

      def actions_container!
        @actions_container
      end

      def authorization_container!
        @authorization_container
      end
    end
  end
end