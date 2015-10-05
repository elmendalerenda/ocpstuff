require 'minitest/autorun'
require './order_price'

class OrderPriceTest < Minitest::Test
  def test_sums_the_items_prices
    item = Item.new('Nurse costume', usd(19.99))
    item_mutator = ItemMutator.new(item)

    total = OrderPrice.new([item_mutator]).calculate

    assert_equal(usd(19.99), total)
  end

  def test_applies_the_shipping_fees
    shipping_fees = MiniTest::Mock.new
    destination = 'CA'
    shipping_fees.expect :to, usd(10.00), [destination]
    shipping_fee_mutator = ShippingFeeMutator.new(shipping_fees, destination)

    total = OrderPrice.new(
      [shipping_fee_mutator]).calculate

    assert_equal(usd(10.00), total)
    shipping_fees.verify
  end

  def test_applies_coupons
    coupons = MiniTest::Mock.new
    coupon_code = 'XMAS15'
    coupons.expect :discount, usd(3.00), [coupon_code]
    coupons_mutator = CouponsMutator.new(coupons, coupon_code)

    total = OrderPrice.new(
      [coupons_mutator]).calculate

    assert_equal(usd(-3.00), total)
    coupons.verify
  end

  def usd(amount)
    Money.new(amount, 'USD')
  end
end
