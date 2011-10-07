Before('@omniauth_test_success') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
    "provider"  => "facebook",
    "uid"       => '12345',
    "user_info" => {
      "email" => "user@test.com",
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname"
    }
  }

  OmniAuth.config.mock_auth[:vkontakte] = {
    "provider"  => "vkontakte",
    "uid"       => '12345',
    "user_info" => {
      "email" => "user@test.com",
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname"
    }
  }
end

Before('@omniauth_test_without_email') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
    "provider"  => "facebook",
    "uid"       => '12345',
    "user_info" => {
      "email" => nil,
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname"
    }
  }

  OmniAuth.config.mock_auth[:vkontakte] = {
    "provider"  => "vkontakte",
    "uid"       => '12345',
    "user_info" => {
      "email" => nil,
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname"
    }
  }
end

Before('@omniauth_test_failure') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  OmniAuth.config.mock_auth[:vkontakte] = :invalid_credentials
end

After('@omniauth_test_after') do
  OmniAuth.config.test_mode = false
end
