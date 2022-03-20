require './config/load/env'
require './services/bot/application'
require 'logger'
require './services/kernel/lib'
require_relative '../db/connection'

module Config
  module Initialize
    include Services::Kernel::Lib

    def load_configuration!(app_mode: nil)
      return if app_mode.blank?

      environment = Config::Load::Env.new(app_mode: app_mode)
      Db::Connection.instance.adapter(connection_params:environment)
      @app_mode = app_mode
      @application = Services::Bot::Application.new(env: environment, logger: logger!)
    end

    def application!
      @application
    end
  end
end