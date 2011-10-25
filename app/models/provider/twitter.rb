class Provider::Twitter < Provider::Provider
  def profile_link
    'http://twitter.com/#!/' + @uid if @uid
  end

  def provider_icon
    'ico_twitter.png'
  end
end
