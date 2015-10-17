def fizz_buzz(number)
  rules = [Fizz, Buzz, Bang]
  result = rules.reduce(''){ |acc, rule| acc + rule.new.apply(number) }

  return result unless result.empty?
  number
end

class Fizz
  def apply(number)
    return 'Fizz' if (number % 3).zero?
    return ''
  end
end

class Buzz
  def apply(number)
    return 'Buzz' if (number % 5).zero?
    return ''
  end
end

class Bang
  def apply(number)
    return 'Bang' if (number % 7).zero?
    return ''
  end
end
