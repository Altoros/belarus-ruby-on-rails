class Provider::Provider
  def initialize(uid)
    @uid = uid.to_s if uid
  end

  def printable_name
    class_without_namespace
  end

  def provider_name
    class_without_namespace.underscore.to_sym
  end

  def provider_icon
    raise NoMethodError, I18n.t('exception.no_icon_for_provider', :provider_name => self.class.name)
  end

  private

  def class_without_namespace
    self.class.name.split('::').last
  end
end
