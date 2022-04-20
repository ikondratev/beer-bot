require "require_all"
require "figaro"
require "logger"
require "singleton"
require "active_record"
require "pg"
require "base64"
require "telegram/bot"
require "dry/system/container"
require "./config/load/env"
require_all "./constants"
require_all "./services"
require_all "./db/connection"

module Config
  module Initialize
    include Services::Kernel::Lib

    def load_configuration!(app_mode = :development)
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