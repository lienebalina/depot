class CopyPriceInLineItem < ActiveRecord::Migration[7.1]
  def change
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
  end
end
