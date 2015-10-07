class OrderPrice
  def initialize(mutators)
    @mutators = AmountMutators.new(mutators)
  end

  def calculate
    amount = @mutators.apply

    Money.new(amount, 'USD')
  end

  private

  class AmountMutators
    def initialize(mutators)
      @mutators = mutators
    end

    def apply
      m = @mutators.find {|e| e.is_a?(CouponsMutator) }
      @mutators.delete_if {|e| e.is_a?(CouponsMutator) }
      @mutators << m if m
      @mutators.reduce(0) { |acc, mutator | acc + mutator.apply(acc) }
    end
  end
end

class ShippingFeeMutator
  def apply(_)
    @shipping_fees.to(@destination).amount
  end

  def initialize(shipping_fees, destination)
    @shipping_fees = shipping_fees
    @destination = destination
  end
end

class CouponsMutator
  def apply(amount)
    (amount * @coupons.discount(@coupon_code) * -1).round(2)
  end

  def initialize(coupons, coupon_code)
    @coupons = coupons
    @coupon_code = coupon_code
  end
end

class ItemMutator
  def apply(_)
    @item.price.amount
  end

  def initialize(item)
    @item = item
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
