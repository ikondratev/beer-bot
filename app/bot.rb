require './config/load/env'
require './services/bot/application'
require_relative '../database/connection'

APP_MODE = ARGV[0]

return unless Constants::Inner::MODES.include?(APP_MODE)

environment = Config::Load::Env.new(app_mode: APP_MODE)
Database::Connection.instance.adapter(connection_params:environment)
application = Services::Bot::Application.new(env: environment)
application.start
