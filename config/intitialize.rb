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
require "./config/load/containers"
require_all "./constants"
require_all "./services"
require_all "./db/connection"

module Config
  module Initialize
    include Services::Kernel::Lib
    include Config::Load::Containers

    def load_configuration!(app_mode = :development)
      app_environment = Config::Load::Env.new(mode: app_mode)
      base_environment = Config::Load::Env.new(mode: :base)
      Db::Connection.instance.adapter(env: base_environment)

      # ...
      # Containers DI
      # ...
      initialize_containers

      # ...
      # Set var to current thread
      # main thread in general case
      #  ...
      # In case of multi Thread
      # it will be works the same
      # ...
      thread = Thread.current
      thread[:actions] = @actions_container
      thread[:authorization] = @authorization_container
      thread[:pencil] = @pencil_container
      thread[:logger] = @logger

      @app_mode = app_mode
      @application = Services::Bot::Application.new(env: app_environment)
    end

    def application!
      @application
    end
  end
end