require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test

  def test_returns_the_input
    assert_equal(1, fizz_buzz(1))
  end

  def test_fizz_for_numbers_multiple_of_3
    assert_equal('Fizz', fizz_buzz(3))
    assert_equal('Fizz', fizz_buzz(6))
    assert_equal('Fizz', fizz_buzz(9))
  end

  def fizz_buzz(number)
    number
  end
end

