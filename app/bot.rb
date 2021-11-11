require 'telegram/bot'
require './constants/inner'
require './config/load/env'
require './services/bot/actions'

APP_MODE    = ARGV[0]
BOT_ACTIONS = Constants::Inner::BOT_ACTIONS
MODES       = Constants::Inner::MODES

return unless MODES.include?(APP_MODE)

environment = Config::Load::Env.new(app_mode: APP_MODE)
bot_actions = Services::Bot::Actions.new(BOT_ACTIONS)
TOKEN       = environment.store(value: "token")

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    if BOT_ACTIONS.include?(message.text)
      response = bot_actions.call(message: message)
      bot.api.send_message(response)
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Actions is not confirmed")
    end
  end
end