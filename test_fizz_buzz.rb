require 'minitest/autorun'
require './fizz_buzz'

class FizzBuzzTest < Minitest::Test

  def test_returns_the_input
    assert_equal(1, fizz_buzz(1))
  end

  def test_fizz_for_numbers_multiple_of_3
    assert_equal('Fizz', fizz_buzz(3))
    assert_equal('Fizz', fizz_buzz(6))
    assert_equal('Fizz', fizz_buzz(9))
  end

  def test_buzz_for_numbers_multiple_of_5
    assert_equal('Buzz', fizz_buzz(5))
    assert_equal('Buzz', fizz_buzz(10))
    assert_equal('Buzz', fizz_buzz(20))
  end

  def test_fizzbuzz_for_numbers_multiple_of_3_and_5
    assert_equal('FizzBuzz', fizz_buzz(5*3))
    assert_equal('FizzBuzz', fizz_buzz(5*3*2))
    assert_equal('FizzBuzz', fizz_buzz(5*3*7))
  end
end

