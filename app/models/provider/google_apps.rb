class Provider::GoogleApps < Provider::Provider
  def profile_link
    '' if @uid
  end
end
