class Provider::GoogleApps < Provider::Provider
  def profile_link
    @uid
  end

  def provider_icon
    'ico_google_plus.png'
  end
end
