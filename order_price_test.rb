require 'minitest/autorun'
require './order_price'

class OrderPriceTest < Minitest::Test

  def test_sums_the_items_prices
    item_one = Item.new('Google Chromecast', Money.new(37.99, 'USD'))
    item_two = Item.new('Nurse costume', Money.new(19.99, 'USD'))

    total = OrderPrice.new([item_one, item_two]).calculate

    assert_equal(57.98, total.amount.round(2))
  end

  def test_adds_the_shipping_fees
    item = Item.new('Google Chromecast', Money.new(37.99, 'USD'))

    @shipping_fees = MiniTest::Mock.new
    @shipping_fees.expect :to, 10.00, ['CA']
    @shipping_fees.expect :nil?, false

    total = OrderPrice.new([item], @shipping_fees, 'CA').calculate
    assert_equal(47.99, total.amount.round(2))

    @shipping_fees.verify
  end
end
