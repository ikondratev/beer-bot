module Config
  module Load
    module Env
      require 'figaro'

      def self.abra(app_mode: "test")
        Figaro.application = Figaro::Application.new(environment: app_mode, path:Enviroment::MODES[app_mode.to_s])
        Figaro.load
        Figaro.env.token
      end
    end
  end
end