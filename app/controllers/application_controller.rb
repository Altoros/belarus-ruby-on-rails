class ApplicationController < ActionController::Base
  before_filter :set_current_meetup
  before_filter :set_locale

  def set_locale
    I18n.locale = current_user.profile.locale.to_sym if current_user
  end

  rescue_from CanCan::AccessDenied do |e|
    if current_user
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/403.html", :status => :forbidden }
        format.js   { render :text => e.message, :status => :forbidden }
      end
    else
      store_location
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js   { render :js => "window.location='#{ login_path }'" }
      end
    end
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :render_error_page if Rails.env == "production"
  #rescue_from StandardError, :with => :render_error_page if Rails.env == "production"

  # Catches any missing methods and calls the general render_error_page method
  def method_missing(*args)
    render_error_page if Rails.env == "production"
  end

  # General method to render a 404
  def render_error_page
    render :template => "shared/error_page", :status => 404
  end

  protect_from_forgery
  include SessionsHelper

  def export_i18n_messages
    I18n.export! if Rails.env.development?
  end

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      get_stored_location
    else
      super
    end
  end

  protected

  def set_current_meetup
    @meetups = Meetup.active.recent
  end

  def ckeditor_authenticate
    if current_user.try(:is_admin?)
      self.class_eval do
        skip_authorization_check
      end
    end
  end
end
