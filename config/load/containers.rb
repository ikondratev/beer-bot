require 'dry/system/container'
require './services/containers/action'
require './services/containers/authorization'
require './services/containers/pencil'

module Config
  module Load
    module Containers
      def initialize_containers
        container = Dry::Container.new
        container.register(:actions, Services::Containers::Action.new)
        container.register(:authorization, Services::Containers::Authorization.new)
        container.register(:pencil, Services::Containers::Pencil.new)
        @actions_container = container.resolve(:actions)
        @authorization_container = container.resolve(:authorization)
        @pencil_container = container.resolve(:pencil)
      end

      def actions_container!
        @actions_container
      end

      def authorization_container!
        @authorization_container
      end

      def pencil_container!
        @pencil_container
      end
    end
  end
end
