# frozen_string_literal: true

# migration class for creating carts
class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts, &:timestamps
  end
end
