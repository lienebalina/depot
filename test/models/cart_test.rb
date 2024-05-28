require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "adding unique products to the cart" do
    cart = Cart.create
    product1 = products(:ruby)
    product2 = products(:two)

    cart.add_product(product1)
    cart.add_product(product2)

    assert_equal 2, cart.unique_line_items_count
  end

  test "adding duplicate products to the cart" do
    cart = Cart.create
    product = products(:ruby)

    cart.add_product(product)
    cart.add_product(product)

    assert_equal 1, cart.unique_line_items_count
    assert_equal 2, cart.item_count
  end
end
