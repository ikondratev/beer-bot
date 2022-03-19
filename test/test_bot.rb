require 'minitest/autorun'

module Test
  class BotTest < Minitest::Test
    def test_first
      assert_equal("1", "1")
    end
  end
end