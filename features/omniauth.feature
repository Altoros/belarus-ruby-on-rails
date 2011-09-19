Feature: OmniAuth authorization
  In order to get access to protected sections of the site
  A user
  Should be able to sign in via external authorization provider

    @omniauth_test_success @omniauth_test_after
    Scenario: A user successfully signs in with Facebook
      Given I am on the homepage
      And I follow "Login"
      When I follow "Sign in with Facebook"
      Then I should see "Logout"

    @omniauth_test_failure @omniauth_test_after
    Scenario: A user unsuccessfully signs in with Facebook
      Given I am on the homepage
      And I follow "Login"
      When I follow "Sign in with Facebook"
      Then I should see "Could not authorize you from Facebook because"