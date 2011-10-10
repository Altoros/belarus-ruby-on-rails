class Provider::Twitter < Provider::Provider
  def profile_link
    'http://twitter.com/#!/' + @uid if @uid
  end
end
