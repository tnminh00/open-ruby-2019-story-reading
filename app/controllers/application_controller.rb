class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

  def check_is_admin
    return if current_user&.is_admin?
    flash[:danger] = t ".not_admin"
    redirect_to root_path
  end
end
