module Config
  module Load
    class Env
      require 'figaro'
      require './constants/inner'

      def initialize(app_mode: "test")
        path = Constants::Inner::MODES[app_mode.to_s]
        Figaro.application = Figaro::Application.new(environment: app_mode, path: path)
        Figaro.load
      end

      def store(value:)
        Figaro.env.send(value)
      end
    end
  end
end
