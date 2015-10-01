class OrderPrice
  def initialize(items)
    @items = Items.new(items)
  end

  def calculate
    Money.new(@items.amount, @items.currency)
  end

  class Items
    def initialize(items)
      @items = items
    end

    def amount
      @items.reduce(0) { |acc, item| acc + item.price.amount }
    end

    def currency
      @items.first.price.currency
    end
  end
end

class Item < Struct.new(:name, :price); end
class Money < Struct.new(:amount, :currency);end
