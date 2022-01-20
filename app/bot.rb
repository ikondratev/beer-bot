require './config/load/env'
require './services/bot/application'

APP_MODE = ARGV[0]

return unless Constants::Inner::MODES.include?(APP_MODE)

environment = Config::Load::Env.new(app_mode: APP_MODE)
application = Services::Bot::Application.new(env: environment)
application.start
