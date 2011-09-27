Feature:
  OmniAuth authorization via Facebook
  In order to get access to protected sections of the site
  A user
  Should be able to sign in via external authorization provider Facebook

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without Facebook token could bind it
      When I follow "Bind with Facebook"
      Then I should see "http://www.facebook.com/profile.php"
