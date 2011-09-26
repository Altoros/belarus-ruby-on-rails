module UserManagerHelper
  def can(action, subject = nil)
    user_signed_in? and
    case action
      when :admin, :change_admin  then current_user.is_admin
      else false
    end
  end

  def filter(action, subject = nil)
    redirect_to_login_path unless can_result = can(action, subject)
    can_result
  end

  private
  def redirect_to_login_path
    if request.xml_http_request?
      render :js => "window.location='#{ login_path }'"
    else
      redirect_to login_path
    end
  end

  def link_to_admin_title user
    if user.is_admin?
      "Remove admin"
    else
      "Make admin"
    end
  end

  def admin_filter
    filter :admin
  end
end
