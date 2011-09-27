class Provider::Provider
  def initialize(uid)
    @uid = uid.to_s if uid
  end

  def printable_name
    class_without_namespace
  end

  def provider_name
    class_without_namespace.downcase.to_sym
  end

  private

  def class_without_namespace
    self.class.name.split('::').last
  end
end
