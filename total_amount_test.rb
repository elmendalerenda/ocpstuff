require "minitest/autorun"

class OrderPriceTest < Minitest::Test

  def test_sums_the_items_prices
    item_one = Item.new('Google Chromecast', Money.new(37.99, 'USD'))
    item_two = Item.new('Nurse costume', Money.new(19.99, 'USD'))

    total = OrderPrice.new([item_one, item_two]).calculate

    assert_equal(57.98, total.amount.round(2))
  end

  class Item < Struct.new(:name, :price); end

  class Money < Struct.new(:amount, :currency);end

  class OrderPrice
    def initialize(items)
      @items = items
    end

    def calculate
      amount = @items.reduce(0) { |acc, item| acc + item.price.amount }
      Money.new(amount, 'USD')
    end
  end
end
