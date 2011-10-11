class Provider::LinkedIn < Provider::Provider
  def profile_link
    'http://www.linkedin.com/pub/' + @uid if @uid
  end
end
