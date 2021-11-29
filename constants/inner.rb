module Constants
  module Inner
    MODES = {
      "production" => "./config/production.yml",
      "development" => "./config/development.yml",
      "test" => "./config/test.yml"
    }.freeze

    BOT_ACTIONS = %w[/start /hello /stop].freeze
  end
end