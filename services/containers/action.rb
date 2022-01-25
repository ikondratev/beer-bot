require './services/containers/actions/add_user_action'
require './services/containers/actions/greeting_action'

module Services
  module Containers
    class Action
      def call(message: nil, action: nil, params: nil)
        response = actions(message, action, params)
        prepare_response(response)
      end

      private

      def actions(message, action, params)
        case action
        when "/start"    then "Hello #{message.from.first_name} #{greeting(message)}"
        when "/info"     then greeting(message)
        when "/ping"     then "pong #{message.from.first_name}"
        when "/add_user" then add_user(params)
        else  "Unidentified action #{message.from.first_name}"
        end
      end

      def add_user(params)
        Services::Containers::Actions::AddUserAction.new.call(params: params)
      end

      def greeting(message)
        Services::Containers::Actions::GreetingAction.new.call(message: message)
      end

      def prepare_response(text)
        { text: text }
      end
    end
  end
end