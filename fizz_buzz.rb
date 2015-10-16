def fizz_buzz(number)
  result = ''
  result = 'Fizz' if multiple_of_3(number)
  result += 'Buzz' if multiple_of_5(number)

  return result unless result.empty?
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
