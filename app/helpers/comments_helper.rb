class CommentsHelper
  def can(action, subject = nil)
    user_signed_in? and
    case action
      when :add_comment then true
      when :change_comment then current_user.id == subject.user.id or current_user.is_admin
      when :remove_comment then current_user.id == subject.user.id or current_user.is_admin
      else false
    end
  end

  def filter_ajax(action, subject = nil)
    unless can action, subject
      render js: "window.location='#{ login_path }'"
    end
  end
end