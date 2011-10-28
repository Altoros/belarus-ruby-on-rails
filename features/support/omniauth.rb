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

  OmniAuth.config.mock_auth[:google_apps] = {
    "provider"  => "google_apps",
    "uid"       => '12345',
    "user_info" => {
      "email" => "user@test.com",
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname"
    }
  }

  OmniAuth.config.mock_auth[:twitter] = {
    "provider"  => "twitter",
    "uid"       => '12345',
    "user_info" => {
      "email" => "user@test.com",
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname",
      "nickname"   => "nickname"
    }
  }

  OmniAuth.config.mock_auth[:github] = {
    "provider"  => "github",
    "uid"       => '12345',
    "user_info" => {
      "email" => "user@test.com",
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname",
      "nickname"   => "nickname"
    },
    "extra" => {
      "user_hash" => {
        "login" => "login"
      }
    }

  }

  OmniAuth.config.mock_auth[:linked_in] = {
    "provider"  => "linked_in",
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

  OmniAuth.config.mock_auth[:google_apps] = {
    "provider"  => "google_apps",
    "uid"       => '12345',
    "user_info" => {
      "email" => nil,
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname"
    }
  }

  OmniAuth.config.mock_auth[:twitter] = {
    "provider"  => "twitter",
    "uid"       => '12345',
    "user_info" => {
      "email" => nil,
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname",
      "nickname"   => "nickname"
    }
  }

  OmniAuth.config.mock_auth[:github] = {
    "provider"  => "github",
    "uid"       => '12345',
    "user_info" => {
      "email" => nil,
      "first_name" => "Name",
      "last_name"  => "Surname",
      "name"       => "Name Surname",
      "nickname"   => "nickname"
    },
    "extra" => {
      "user_hash" => {
        "login" => "login"
      }
    }
  }

  OmniAuth.config.mock_auth[:linked_in] = {
    "provider"  => "linked_in",
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
  OmniAuth.config.mock_auth[:google_apps] = :invalid_credentials
  OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  OmniAuth.config.mock_auth[:github] = :invalid_credentials
  OmniAuth.config.mock_auth[:linked_in] = :invalid_credentials
end

After('@omniauth_test_after') do
  OmniAuth.config.test_mode = false
end
