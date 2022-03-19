require './config/load/env'
require './services/bot/application'
require 'logger'
require_relative '../db/connection'

module Config
  module Initialize
    def load_configuration!(app_mode: nil)
      return if app_mode.blank?

      environment = Config::Load::Env.new(app_mode: app_mode)
      Db::Connection.instance.adapter(connection_params:environment)
      logger = Logger.new(STDOUT)
      @application = Services::Bot::Application.new(env: environment, logger: logger)
    end

    def require_dir(path)
      dir = Dir.glob File.join(path,  '*.rb')
      dir.each { |file| require file }
    end

    def application!
      @application.start
    end
  end
end