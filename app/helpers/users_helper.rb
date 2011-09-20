module UsersHelper
  def can(action, arg = nil)
    case action
      when :add_comment then user_signed_in?
      when :change_comment then user_signed_in? and (current_user.id == arg.user.id or current_user.is_admin)
      when :remove_comment then user_signed_in? and (current_user.id == arg.user.id or current_user.is_admin)
      when :admin  then user_signed_in? and current_user.is_admin
      when :change_admin  then user_signed_in? and current_user.is_admin
      else false
    end
  end

  def filter_ajax(action, object = nil)
    unless can action, object
      render js: "window.location='#{new_user_session_path}'"
    end
  end

  def filter(action, object = nil)
    unless can action, object
      redirect_to new_user_session_path
    end
  end

  def link_to_admin_title user
    if user.is_admin?
      "Remove admin"
    else
      "Make admin"
    end
  end
end