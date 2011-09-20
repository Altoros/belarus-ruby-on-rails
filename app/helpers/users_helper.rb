module UsersHelper
  def can(action, *args)
    case action
      when :add_comment then user_signed_in?
      when :change_comment then user_signed_in? and (current_user.id == args[0].user.id or current_user.is_admin)
      when :remove_comment then user_signed_in? and (current_user.id == args[0].user.id or current_user.is_admin)
      else false
    end
  end
end