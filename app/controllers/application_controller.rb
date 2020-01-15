class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :load_noti_user
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

  def check_is_admin
    return if current_user&.is_admin?
    flash[:danger] = t ".not_admin"
    redirect_to root_path
  end

  def load_history
    if current_user
      @chapters = current_user.chapters.page(params[:page]).per Settings.perpage
    else
      redirect_to login_path
    end
  end

  def load_story
    @story = Story.find_by id: params[:id]
    
    return if @story
    
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def load_noti_user
    @notifications = current_user.notifications.order_by_create if current_user
  end

  def render_notification notification
    ApplicationController.renderer.render partial: "notifications/notification", locals: { notification: notification }
  end
end
