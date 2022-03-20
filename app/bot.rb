require './config/intitialize'

module App
  class Bot
    include Config::Initialize

    # @param [String] app_mode
    # @example development test production
    def initialize(app_mode: :test)
      # Load environment based on app_mode:
      load_configuration!(app_mode: app_mode)
    end

    # @author
    # Main point to start server
    # Add thread with telegram bot api
    # Unless process was killed
    def up
      safe { application!.start }
    end
  end
end
