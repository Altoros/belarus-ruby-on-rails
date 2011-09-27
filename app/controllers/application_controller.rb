class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do
    if current_user
      if request.xml_http_request?
        render :js => "window.location='#{ root_path }403.html'"
      else
        render :file => "#{Rails.root}/public/403.html", :status => 403
      end
    else
      if request.xml_http_request?
        render :js => "window.location='#{ login_path }'"
      else
        redirect_to login_path
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
end
