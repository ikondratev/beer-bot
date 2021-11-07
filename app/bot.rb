require 'telegram/bot'
require './constants/environment'
require './config/load/env'

APP_MODE = ARGV[0]

return unless Enviroment::MODES.include?(APP_MODE)

TOKEN = Config::Load::Env.abra(app_mode: APP_MODE)

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, pidor")
    when '/hello'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello pidor")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end