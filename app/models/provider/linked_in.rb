class Provider::LinkedIn < Provider::Provider
  def profile_link
    'http://www.linkedin.com/pub/' + @uid if @uid
  end

  def provider_icon
    'ico_linkedin.png'
  end
end
