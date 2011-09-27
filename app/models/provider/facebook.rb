class Provider::Facebook < Provider::Provider
  def profile_link
    'http://www.facebook.com/profile.php?id=' + @uid if @uid
  end
end
