class OrderPrice
  def initialize(items, shipping_fees, destination, coupons=nil, coupon_code=nil)
    @items = Items.new(items)
    @shipping_fees = shipping_fees
    @destination = destination
    @coupons = coupons
    @coupon_code = coupon_code
  end

  def calculate
    amount = @items.amount
    amount = add_shipping_fees(amount)
    unless (@coupons.nil?)
      amount -= @coupons.discount(@coupon_code).amount
    end

    Money.new(amount, @items.currency)
  end

  private

  def add_shipping_fees(amount)
    amount += @shipping_fees.to(@destination)
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
