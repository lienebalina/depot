# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
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

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      elsif session[:locale] # fix language bug
        I18n.locale = session[:locale]
      end
    end

    def authorize
      return if Rails.env.development? && request.path.start_with?('/rails/action_mailbox')

      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end
end
