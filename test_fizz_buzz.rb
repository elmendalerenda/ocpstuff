require 'minitest/autorun'
require './fizz_buzz'

class FizzBuzzTest < Minitest::Test

  def test_returns_the_input
    assert_equal(1, fizz_buzz(1))
  end

  def test_fizz_for_numbers_multiple_of_3
    assert_equal(3, fizz_buzz(3))
    assert_equal(3, fizz_buzz(6))
    assert_equal(3, fizz_buzz(9))
  end

  def test_buzz_for_numbers_multiple_of_5
    assert_equal(5, fizz_buzz(5))
    assert_equal(5, fizz_buzz(10))
    assert_equal(5, fizz_buzz(20))
  end

  def test_fizzbuzz_for_numbers_multiple_of_3_and_5
    assert_equal(8, fizz_buzz(5*3))
    assert_equal(8, fizz_buzz(5*3*2))
    assert_equal(8, fizz_buzz(5*3*11))
  end

  def test_bang_for_multiple_of_7
    assert_equal(7, fizz_buzz(7))
    assert_equal(7, fizz_buzz(7*2))
  end

  def test_fizzbang_for_numbers_multiple_of_3_and_7
    assert_equal(10, fizz_buzz(3 * 7))
    assert_equal(10, fizz_buzz(3 * 7 * 2))
    assert_equal(10, fizz_buzz(3 * 7 * 11))
  end
end

