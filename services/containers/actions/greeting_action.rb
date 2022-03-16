require './constants/inner'

module Services
  module Containers
    module Actions
      class GreetingAction
        def call(_message: nil)
          greeting
        end

        private

        def greeting
          "Available commands: #{Constants::Inner::BOT_ACTIONS}"
        end
      end
    end
  end
end
