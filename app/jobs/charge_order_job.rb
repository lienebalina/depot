class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, pay_type_params)
    order.charge!(pay_type_params)
  rescue StandardError => e
    ErrorNotifierMailer.payment_failure(order, e.message).deliver_now
  end
end
