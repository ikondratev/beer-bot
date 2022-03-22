require 'minitest/autorun'
require './app/bot'

module Test
  class TestBot < Minitest::Test
    def setup
      @bot = App::Bot.new(app_mode: "production")
    end

    def test_bot_initialize
      assert_equal(App::Bot, @bot.class)
    end
  end
end
