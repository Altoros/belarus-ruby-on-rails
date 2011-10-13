Feature:
  OmniAuth authorization via Google Apps
  In order to get access to protected sections of the site
  A user
  Should be able to sign in via external authorization provider Google Apps

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without Google Apps token could bind it
      When I follow "Bind with GoogleApps"
      Then I should see "user@test.com"
