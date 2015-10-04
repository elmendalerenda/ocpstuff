class OrderPrice
  def initialize(items, shipping_fees, destination, coupons, coupon_code)
    @items = Items.new(items)
    @shipping_fees = shipping_fees
    @destination = destination
    @coupons = coupons
    @coupon_code = coupon_code
  end

  def calculate
    amount = @items.amount
    amount = apply_shipping_fees(amount)
    amount = apply_coupon(amount)

    Money.new(amount, @items.currency)
  end

  private

  def apply_shipping_fees(amount)
    amount += @shipping_fees.to(@destination)
  end

  def apply_coupon(amount)
    amount -= @coupons.discount(@coupon_code).amount
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
class Money < Struct.new(:amount, :currency)
  def amount
    super.round(2)
  end

  def ==(other)
    amount == other.amount && currency == other.currency
  end
end
