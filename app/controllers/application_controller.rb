# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :handle_error

  def render404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  def handle_error(error)
    ErrorNotifierMailer.notify_error(error).deliver_now
    render file: "#{Rails.root}/public/500.html", layout: false, status: :internal_server_error
  end
end
