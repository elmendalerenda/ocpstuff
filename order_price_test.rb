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

  def test_applies_discount_percentage
    coupons = MiniTest::Mock.new
    coupon_code = 'XMAS15'
    coupons.expect :discount, 0.1, [coupon_code]
    item = Item.new('Nurse costume', usd(19.99))

    total = OrderPrice.new(
      [
        ItemMutator.new(item),
        CouponsMutator.new(coupons, coupon_code)
      ]
    ).calculate

    assert_equal(usd(17.99), total)
    coupons.verify
  end

  def test_applies_coupon_percentage_always_at_the_end
    coupons = MiniTest::Mock.new
    coupon_code = 'XMAS15'
    coupons.expect :discount, 0.1, [coupon_code]
    item = Item.new('Nurse costume', usd(19.99))

    total = OrderPrice.new(
      [
        CouponsMutator.new(coupons, coupon_code),
        ItemMutator.new(item)
      ]
    ).calculate

    assert_equal(usd(17.99), total)
    coupons.verify
  end

  def test_ignore_shipping_fee_if_total_greater_than_1000
    coupons = MiniTest::Mock.new
    coupon_code = 'XMAS15'
    coupons.expect :discount, 0.1, [coupon_code]
    item = Item.new('Samsung Curved 4K 105 inches', usd(200_000.00))
    shipping_fees = MiniTest::Mock.new

    total = OrderPrice.new(
      [
        CouponsMutator.new(coupons, coupon_code),
        ShippingFeeMutator.new(shipping_fees, 'CA'),
        ItemMutator.new(item)
      ]
    ).calculate

    assert_equal(usd(180_000.00), total)
    coupons.verify
  end

  def usd(amount)
    Money.new(amount, 'USD')
  end
end
