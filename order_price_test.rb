require 'minitest/autorun'
require './order_price'

class OrderPriceTest < Minitest::Test
  def test_sums_the_items_prices
    item = Item.new('Chewbacca costume', usd(19.99))
    item_mutator = ItemMutator.new(item)

    total = OrderPrice.new([item_mutator]).calculate

    assert_equal(usd(19.99), total)
  end

  def test_applies_the_shipping_fees_always_10
    shipping_fee_mutator = ShippingFeeMutator.new

    total = OrderPrice.new(
      [shipping_fee_mutator]).calculate

    assert_equal(usd(10.00), total)
  end

  def test_applies_discount_percentage_always_10_pct
    item = Item.new('Chewbacca costume', usd(19.99))

    total = OrderPrice.new(
      [
        ItemMutator.new(item),
        CouponsMutator.new
      ]
    ).calculate

    assert_equal(usd(17.99), total)
  end

  def test_applies_coupon_percentage_always_at_the_end
    item = Item.new('Chewbacca costume', usd(19.99))

    total = OrderPrice.new(
      [
        CouponsMutator.new,
        ItemMutator.new(item)
      ]
    ).calculate

    assert_equal(usd(17.99), total)
  end

  def test_ignore_shipping_fee_if_total_greater_than_1000
    item = Item.new('Samsung Curved 4K 105 inches', usd(200_000.00))

    total = OrderPrice.new(
      [
        CouponsMutator.new,
        ShippingFeeMutator.new,
        ItemMutator.new(item)
      ]
    ).calculate

    assert_equal(usd(180_000.00), total)
  end

  def usd(amount)
    Money.new(amount, 'USD')
  end
end
