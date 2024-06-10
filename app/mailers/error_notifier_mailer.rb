class ErrorNotifierMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notify_error(error)
    @error = error
    mail(to: 'admin@example.com', subject: 'Application error occured')
  end

  def payment_failure(order, error_message)
    @order = order
    @error_message = error_message
    mail(to: 'admin@example.com', subject: 'Payment failure occured')
  end
end
