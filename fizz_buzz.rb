def fizz_buzz(number)
  return 'Fizz' if multiple_of_3(number)
  return 'Buzz' if multiple_of_5(number)
  number
end

def multiple_of_3(number)
  (number % 3).zero?
end

def multiple_of_5(number)
  (number % 5).zero?
end
