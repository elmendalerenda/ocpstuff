def fizz_buzz(number)
  return 'Fizz' if multiple_of_3(number)
  number
end

def multiple_of_3(number)
  (number % 3).zero?
end
