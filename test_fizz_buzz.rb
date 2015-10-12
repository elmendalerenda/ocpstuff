require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test

  def test_returns_the_input
    assert_equal(1, fizz_buzz(1))
  end

  def fizz_buzz(number)
    number
  end
end

