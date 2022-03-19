require 'minitest/autorun'
require './app/bot'

module Test
  class TestBot < Minitest::Test
    def test_bot_initialize
      assert_equal(App::Bot, App::Bot.new(app_mod: "production").class)
    end
  end
end