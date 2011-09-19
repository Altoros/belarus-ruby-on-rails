class ApplicationController < ActionController::Base
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
