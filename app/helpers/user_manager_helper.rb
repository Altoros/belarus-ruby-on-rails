module UserManagerHelper
  def link_to_admin_title user
    if user.is_admin?
      "Remove admin"
    else
      "Make admin"
    end
  end
end
