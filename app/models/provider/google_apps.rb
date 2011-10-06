class Provider::GoogleApps < Provider::Provider
  def profile_link
    @uid if @uid
  end
end
