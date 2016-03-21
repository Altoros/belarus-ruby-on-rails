class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    profile_path(resource.profile)
  end

  def build_resource(*)
    super
    if Recaptcha.configured?
      self.resource.registration_recaptcha_passed = true if verify_recaptcha(model: self.resource)
      flash.delete(:recaptcha_error)
    end
  end

end
