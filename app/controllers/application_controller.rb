class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do
    if current_user
      render :file => "#{Rails.root}/public/403.html", :status => 403
    else
      redirect_to login_path
    end
  end

  protect_from_forgery
  include SessionsHelper
  include PermissionsHelper

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      get_stored_location
    else
      super
    end
  end
end
