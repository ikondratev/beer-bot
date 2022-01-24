require 'dry/system/container'
require './services/containers/action'
require './services/containers/authorization'

module Config
  module Load
    module Containers
      def initialize_containers
        container = Dry::Container.new
        container.register(:actions, Services::Containers::Action.new)
        container.register(:authorization, Services::Containers::Authorization.new)
        @actions_container = container.resolve(:actions)
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