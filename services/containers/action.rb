require './services/containers/actions/add_user_action'

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
        when "/ping"    then "pong #{message.from.first_name}"
        when "/add_user" then add_user(message, params)
        else  "Unidentified action #{message.from.first_name}"
        end
      end

      def add_user(message, params)
        Services::Containers::Actions::AddUserAction.new.call(message: message, params: params)
      end

      def prepare_response(text)
        { text: text }
      end
    end
  end
end