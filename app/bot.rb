require './config/load/env'
require './services/bot/application'

APP_MODE = ARGV[0]
MODES    = Constants::Inner::MODES

return unless MODES.include?(APP_MODE)

environment = Config::Load::Env.new(app_mode: APP_MODE)

TOKEN        = environment.store(value: "token")
BASE_PARAMS  = { database:  environment.store(value: "db_name"),
                 password:  environment.store(value: "db_password"),
                 user_name: environment.store(value: "db_user_name"),
                 host:      environment.store(value: "db_host") }

application = Services::Bot::Application.new(token: TOKEN)
application.start

0