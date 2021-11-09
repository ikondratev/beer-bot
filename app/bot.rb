require 'telegram/bot'
require './constants/environment'
require './config/load/env'
require './services/bot/actions'

APP_MODE = ARGV[0]

return unless Enviroment::MODES.include?(APP_MODE)

TOKEN = Config::Load::Env.store(
  app_mode: APP_MODE, value: "token")

BOT_ACTIONS = Config::Load::Env.store(
  app_mode: APP_MODE,
  value: "bot_actions")&.split(",")&.map(&:to_s)

actions = Services::Bot::Actions.new(BOT_ACTIONS)

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    if BOT_ACTIONS.include?(message.text)
      response = actions.call(message: message)
      bot.api.send_message(response)
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Actions is not confirmed")
    end
  end
end