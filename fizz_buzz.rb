def fizz_buzz(number)
  rules = [Fizz, Buzz, Bang]
  result = rules.reduce(0){ |acc, rule| acc + rule.new.apply(number) }


  return result unless result.zero?
  number
end

class Fizz
  def apply(number)
    return 3 if (number % 3).zero?
    return 0
  end
end

class Buzz
  def apply(number)
    return 5 if (number % 5).zero?
    return 0
  end
end

class Bang
  def apply(number)
    return 7 if (number % 7).zero?
    return 0
  end
end
