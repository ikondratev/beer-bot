require './config/load/env'
require './services/bot/application'
require_relative '../database/connection'

module Config
  module Initialize
    def load_configuration!(app_mode: nil)
      return if app_mode.blank?

      require_dir("./services/errors")
      environment = Config::Load::Env.new(app_mode: app_mode)
      Database::Connection.instance.adapter(connection_params:environment)
      @application = Services::Bot::Application.new(env: environment)
    end

    def require_dir(path)
      dir = Dir.glob File.join(path,  '*.rb')
      dir.each { |file| require file }
    end

    def application!
      @application
    end
  end
end