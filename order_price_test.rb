require 'minitest/autorun'
require './order_price'

class OrderPriceTest < Minitest::Test
  def setup
    @item = Item.new('Google Chromecast', Money.new(37.99, 'USD'))
    @another_item = Item.new('Nurse costume', Money.new(19.99, 'USD'))
    @destination = 'CA'
    @shipping_fees = MiniTest::Mock.new
    @coupons = MiniTest::Mock.new
    @coupon_code = 'XMAS15'
  end

  def test_sums_the_items_prices
    @shipping_fees.expect :to, 0.00, [@destination]
    @coupons.expect :discount, Money.new(0.00, 'USD'), [@coupon_code]
    total = OrderPrice.new(
      [@item, @another_item],
      @shipping_fees,
      @destination,
      @coupons,
      @coupon_code).calculate

    assert_equal(Money.new(57.98, 'USD'), total)
  end

  def test_applies_the_shipping_fees
    @coupons.expect :discount, Money.new(0.00, 'USD'), [@coupon_code]
    @shipping_fees.expect :to, 10.00, [@destination]

    total = OrderPrice.new(
      [@item],
      @shipping_fees,
      @destination,
      @coupons,
      @coupon_code).calculate

    assert_equal(Money.new(47.99, 'USD'), total)
    @shipping_fees.verify
  end

  def test_applies_coupons
    @shipping_fees.expect :to, 0.00, [@destination]
    @coupons.expect :discount, Money.new(3.00, 'USD'), [@coupon_code]

    total = OrderPrice.new(
      [@item],
      @shipping_fees,
      @destination,
      @coupons,
      @coupon_code).calculate

    assert_equal(Money.new(34.99, 'USD'), total)
    @coupons.verify
  end
end
