Feature:
  OmniAuth authorization via GoogleApps
  In order to get access to protected sections of the site
  A user
  Should be able to sign in via external authorization provider GoogleApps

    Background:
      Given I am not logged in
      And I am on the homepage

    @omniauth_test_success @omniauth_test_after
    Scenario: A user successfully signs in with GoogleApps
      When I follow "Sign in with GoogleApps"
      Then I should see "Logout"

    @omniauth_test_failure @omniauth_test_after
    Scenario: A user unsuccessfully signs in with GoogleApps
      When I follow "Sign in with GoogleApps"
      Then I should see "Could not authorize you from Google apps because"

    @omniauth_test_success @omniauth_test_after
    Scenario: A user after successfull sign in with GoogleApps returns to the same page
      And I come to article page with name "Very specific article 911"
      When I follow "Sign in with GoogleApps"
      Then I should see "Very specific article 911"

    @omniauth_test_success @omniauth_test_after
    Scenario: A user previously registered by email and now successfully signs in with GoogleApps
      And I am a user named "Name" and surnamed "Surname" with an email "user@test.com" and password "please"
      And  I follow "Sign in with GoogleApps"
      When I follow "Edit registration"
      Then I should see "Current password"

    @omniauth_test_success @omniauth_test_after
    Scenario: A user never registered before and now successfully signs in with GoogleApps
      When I follow "Sign in with GoogleApps"
      And  I follow "Edit registration"
      Then I should see "Reset my password"
