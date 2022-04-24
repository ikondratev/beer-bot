module Constants
  MODES = {
    production: "./config/production.yml",
    development: "./config/development.yml",
    test: "./config/test.yml",
    base: "./config/database.yml"
  }.freeze

  BOT_ACTIONS = %w[/ping /add_user /info /start].freeze
  NOT_CONFIRMED = "Actions is not confirmed".freeze
  NOT_AUTHORIZE = "Sorry! You have no right for this operation.".freeze
  BACKEND_ERROR = "Sorry! Something went wrong.".freeze
end
