require './config/load/env'
require './services/bot/application'

APP_MODE = ARGV[0]
MODES    = Constants::Inner::MODES

return unless MODES.include?(APP_MODE)

environment = Config::Load::Env.new(app_mode: APP_MODE)
TOKEN       = environment.store(value: "token")

application = Services::Bot::Application.new(token: TOKEN)
application.start

0