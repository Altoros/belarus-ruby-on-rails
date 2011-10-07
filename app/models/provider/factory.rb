class Provider::Factory
  def self.get_instance(provider, uid = nil)
    provider = provider.to_sym
    case provider
      when :facebook
        Provider::Facebook.new(uid)
      when :vkontakte
        Provider::Vkontakte.new(uid)
      else
        raise NoMethodError, "Not defined provider class"
    end
  end
end
