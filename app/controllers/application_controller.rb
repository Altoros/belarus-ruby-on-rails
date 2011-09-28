class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |e|
    if current_user
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/403.html", :status => :forbidden }
        format.js   { render :text => e.message, :status => :forbidden }
      end
    else
      respond_to do |format|
        format.html { redirect_to login_path }
        format.js   { render :js => "window.location='#{ login_path }'" }
      end

    end
  end

  protect_from_forgery
  include SessionsHelper

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      get_stored_location
    else
      super
    end
  end

  protected
  def ckeditor_authenticate
    authorize! action_name, @asset
  end

  def ckeditor_before_create_asset(asset)
    asset.assetable = current_user
    return true
  end
end
