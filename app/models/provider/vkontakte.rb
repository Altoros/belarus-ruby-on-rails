class Provider::Vkontakte < Provider::Provider
  def profile_link
    'http://vkontakte.ru/id' + @uid if @uid
  end
end
