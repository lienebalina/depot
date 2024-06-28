class SupportRequestsController < ApplicationController
  def index
    @support_requests = SupportRequest.all
    @support_orders = @support_requests.each_with_object({}) do |support_request, hash|
      hash[support_request.id] = Order.where(email: support_request.email)
    end
  end

  def update
    support_request = SupportRequest.find(params[:id])
    support_request.update(response: params.require(:support_request)[:response])
    SupportRequestMailer.respond(support_request).deliver_now
    redirect_to support_requests_path
  end
end
