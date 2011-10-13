Feature: OmniAuth authorization via Facebook
  In order to get access to protected sections of the site
  As a user I should be able to sign in via external authorization provider Facebook

    Background:
      Given I am not logged in
      And I am on the homepage

    @omniauth_test_success @omniauth_test_after
    Scenario: A user successfully signs in with Facebook
      When I follow "Login"
      And I follow "Sign in with Facebook"
      Then I should see "Logout"

    @omniauth_test_failure @omniauth_test_after
    Scenario: A user unsuccessfully signs in with Facebook
      When I follow "Login"
      And I follow "Sign in with Facebook"
      Then I should see "Could not authorize you from Facebook because"

    @omniauth_test_success @omniauth_test_after
    Scenario: A user after successfull sign in with Facebook returns to the same page
      And I come to article page with name "Very specific article 911"
      When I follow "Login"
      And I follow "Sign in with Facebook"
      Then I should see "Very specific article 911"

    @omniauth_test_success @omniauth_test_after
    Scenario: A user previously registered by email and now successfully signs in with Facebook
      And I am a user named "Name" and surnamed "Surname" with an email "user@test.com" and password "please"
      And I follow "Login"
      And  I follow "Sign in with Facebook"
      When I follow "Edit registration"
      Then I should see "Current password"

    @omniauth_test_success @omniauth_test_after
    Scenario: A user never registered before and now successfully signs in with Facebook
      When I follow "Login"
      And I follow "Sign in with Facebook"
      And  I follow "Edit registration"
      Then I should see "Reset my password"
