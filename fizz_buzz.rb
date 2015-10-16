def fizz_buzz(number)
  return 'Fizz' if multiple_of_3(number)
  return 'Buzz' if multiple_of_5(number)
  number
end

def multiple_of_3(number)
  multiple_of(number, 3)
end

def multiple_of_5(number)
  multiple_of(number, 5)
end

def multiple_of(dividend, divisor)
  (dividend % divisor).zero?
end
