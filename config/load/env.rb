module Config
  module Load
    module Env
      require 'figaro'

      def self.store(app_mode: "test", value:)
        Figaro.application = Figaro::Application.new(environment: app_mode, path:Enviroment::MODES[app_mode.to_s])
        Figaro.load
        Figaro.env.send(value)
      end
    end
  end
end