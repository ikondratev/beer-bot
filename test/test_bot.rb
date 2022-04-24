require 'minitest/autorun'
require './app/bot'

module Test
  class TestBot < Minitest::Test
    def setup
      @version = Constants::VERSION
    end

    def test_bot_initialize
      assert_equal("0.0.8", @version)
    end
  end
end
