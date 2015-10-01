class OrderPrice
  def initialize(items, shipping_fees=nil, destination=nil)
    @items = Items.new(items)
    @shipping_fees = shipping_fees
    @destination = destination
  end

  def calculate
    amount = @items.amount
    unless (@shipping_fees.nil?)
      amount += @shipping_fees.to(@destination)
    end

    Money.new(amount, @items.currency)
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
