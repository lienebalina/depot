# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :authorize
  rescue_from StandardError, with: :handle_error

  def render404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  def handle_error(error)
    ErrorNotifierMailer.notify_error(error).deliver_now
    render file: "#{Rails.root}/public/500.html", layout: false, status: :internal_server_error
  end

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end
end
