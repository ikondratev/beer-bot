require './config/intitialize'

include Config::Initialize

APP_MODE = ARGV[0]

return unless Constants::Inner::MODES.include?(APP_MODE)

# Load environment based on app_mode
# example: ["development", "production", "test"]
load_configuration!(app_mode: APP_MODE)

# Main point to start server
application!.start
