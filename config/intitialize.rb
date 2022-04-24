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
require "./services/log/bot_log"
require_all "./constants"
require_all "./services"
require_all "./db/connection"

module Config
  module Initialize
    include Services::Kernel::Lib

    def load_configuration!(app_mode = :development)
      app_environment = Config::Load::Env.new(mode: app_mode)
      base_environment = Config::Load::Env.new(mode: :base)
      Db::Connection.instance.adapter(env: base_environment)
      @app_mode = app_mode
      @application = Services::Bot::Application.new(env: app_environment, logger: logger!)
    end

    def application!
      @application
    end
  end
end