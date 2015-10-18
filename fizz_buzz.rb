def fizz_buzz(number)
  rules = [Fizz, Buzz, Bang, Self]
  result = rules.reduce(''){ |acc, rule| acc + rule.new.apply(number, acc) }

  return result.to_i if is_a_number?(result)
  result
end

def is_a_number?(string)
  /\d+/.match(string)
end

class Fizz
  def apply(number, _)
    return 'Fizz' if (number % 3).zero?
    return ''
  end
end

class Buzz
  def apply(number, _)
    return 'Buzz' if (number % 5).zero?
    return ''
  end
end

class Bang
  def apply(number, _)
    return 'Bang' if (number % 7).zero?
    return ''
  end
end

class Self
  def apply(number, result)
    return number.to_s if result.empty?
    return ''
  end
end
