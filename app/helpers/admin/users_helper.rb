module Admin::UsersHelper
  def link_to_admin_title(user)
    user.is_admin ? t('admin.users.remove_admin') : t('admin.users.make_admin')
  end
end
