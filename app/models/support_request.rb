class SupportRequest < ApplicationRecord
  belongs_to :order, optional: true

    has_rich_text :response

  def self.find_orders_by_email(email)
    Order.where(email: email)
  end
end
