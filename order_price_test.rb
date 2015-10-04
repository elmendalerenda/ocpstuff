require 'minitest/autorun'
require './order_price'

class OrderPriceTest < Minitest::Test

  def setup
    @item = Item.new('Google Chromecast', Money.new(37.99, 'USD'))
    @another_item = Item.new('Nurse costume', Money.new(19.99, 'USD'))
    @destination = 'CA'
    @shipping_fees = MiniTest::Mock.new
  end

  def test_sums_the_items_prices
    @shipping_fees.expect :to, 0.0, [@destination]

    total = OrderPrice.new([@item, @another_item], @shipping_fees, @destination).calculate

    assert_equal(57.98, total.amount.round(2))
  end

  def test_applies_the_shipping_fees
    @shipping_fees.expect :to, 10.00, [@destination]

    total = OrderPrice.new([@item], @shipping_fees, @destination).calculate

    assert_equal(47.99, total.amount.round(2))
    @shipping_fees.verify
  end

  def test_applies_coupons
    @shipping_fees.expect :to, 0.00, [@destination]
    @coupons = MiniTest::Mock.new
    @coupons.expect :discount, Money.new(3.00, 'USD'), ['XMAS15']

    total = OrderPrice.new(
      [@item],
      @shipping_fees,
      @destination,
      @coupons,
      'XMAS2015').calculate

      assert_equal(34.99, total.amount.round(2))
    @coupons.verify
  end
end
