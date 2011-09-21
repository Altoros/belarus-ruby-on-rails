class ConfirmationsController < Devise::ConfirmationsController
  protected

   # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    edit_profile_path(resource.profile)
  end
end
