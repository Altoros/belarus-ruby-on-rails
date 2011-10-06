Feature:
  OmniAuth authorization via GoogleApps
  In order to get access to protected sections of the site
  A user
  Should be able to sign in via external authorization provider GoogleApps

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without GoogleApps token could bind it
      When I follow "Bind with GoogleApps"
      Then I should see "There is no link to profile"
