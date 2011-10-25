class Provider::Facebook < Provider::Provider
  def profile_link
    'http://www.facebook.com/profile.php?id=' + @uid if @uid
  end

  def provider_icon
    'ico_facebook.png'
  end
end
