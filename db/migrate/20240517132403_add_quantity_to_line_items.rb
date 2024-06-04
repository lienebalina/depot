# frozen_string_literal: true

# Migration class for adding quantity to items in cart
class AddQuantityToLineItems < ActiveRecord::Migration[7.1]
  def change
    add_column :line_items, :quantity, :integer, default: 1
  end
end
