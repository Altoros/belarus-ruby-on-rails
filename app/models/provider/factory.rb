class Provider::Factory
  def self.get_instance(provider, uid = nil)
    provider = provider.to_sym
    case provider
      when :facebook
        Provider::Facebook.new(uid)
      when :vkontakte
        Provider::Vkontakte.new(uid)
      when :google_apps
        Provider::GoogleApps.new(uid)
      else
        raise NoMethodError, "Not defined provider class"
    end
  end
end
