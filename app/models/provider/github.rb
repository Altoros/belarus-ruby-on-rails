class Provider::Github < Provider::Provider
  def profile_link
    'https://github.com/' + @uid if @uid
  end

  def provider_icon
    'ico_github.png'
  end
end
