class Provider::Vkontakte < Provider::Provider
  def profile_link
    'http://vkontakte.ru/id' + @uid if @uid
  end

  def provider_icon
    'ico_vk.png'
  end
end
