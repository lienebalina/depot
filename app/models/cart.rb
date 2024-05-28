class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      current_item = line_items.build(
        product_id: product.id,
        price: product.price
      )
      current_item.save
    end
    current_item
  end

  def total_price
    line_items.sum { |item| item.total_price }
  end

  # counts the total quantity of line items
  def item_count
    line_items.sum { |item| item.quantity }
  end

  # counts how many unique products are in the cart
  def unique_line_items_count
    line_items.distinct.count(:product_id)
  end
end
