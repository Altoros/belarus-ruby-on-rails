module UserManagerHelper
  def link_to_admin_title user
    user.is_admin ? "Remove admin" : "Make admin"
  end
end
