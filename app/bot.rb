require './config/intitialize'

include Config::Initialize

APP_MODE = ARGV[0]

return unless Constants::Inner::MODES.include?(APP_MODE)

load(app_mode: APP_MODE)

application!.start
