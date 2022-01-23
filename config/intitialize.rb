require './config/load/env'
require './services/bot/application'
require_relative '../database/connection'

module Config
  module Initialize
    def load(app_mode: nil)
      return if app_mode.blank?

      environment = Config::Load::Env.new(app_mode: app_mode)
      Database::Connection.instance.adapter(connection_params:environment)
      @application = Services::Bot::Application.new(env: environment)
    end

    def application!
      @application
    end
  end
end