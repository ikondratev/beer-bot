require './config/intitialize'

module App
  class Bot
    include Config::Initialize

    def initialize(app_mod: :test)
      @app_mode = app_mod
    end

    def up
      return unless Constants::Inner::MODES.include?(@app_mode)

      # Load environment based on app_mode
      # example: ["development", "production", "test"]
      load_configuration!(app_mode: @app_mode)

      # Main point to start server
      application!
    end
  end
end
