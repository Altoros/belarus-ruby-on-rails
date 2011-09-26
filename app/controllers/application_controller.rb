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

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
   if request.referer
     request.referer
   else
     root_path
   end
  end
end
