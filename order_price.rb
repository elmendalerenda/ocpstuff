class OrderPrice
  def initialize(items, mutators=[])
    @items = Items.new(items)
    @mutators = AmountMutators.new(mutators)
  end

  def calculate
    amount = @items.amount
    amount = apply_mutators(amount)

    Money.new(amount, @items.currency)
  end

  private

  def apply_mutators(amount)
    amount + @mutators.apply
  end

  class AmountMutators
    def initialize(mutators)
      @mutators = mutators
    end

    def apply
      @mutators.reduce(0) { |acc, mutator | acc + mutator.apply }
    end
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

class ShippingFeeMutator
  def apply
    @shipping_fees.to(@destination).amount
  end

  def initialize(shipping_fees, destination)
    @shipping_fees = shipping_fees
    @destination = destination
  end
end

class CouponsMutator
  def apply
    @coupons.discount(@coupon_code).amount * (-1)
  end

  def initialize(coupons, coupon_code)
    @coupons = coupons
    @coupon_code = coupon_code
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
