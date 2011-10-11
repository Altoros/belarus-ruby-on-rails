Feature: OmniAuth authorization via Github
  In order to get access to protected sections of the site
  As a user I should be able to sign in via external authorization provider Github

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without Github token could bind it
      When I follow "Bind with Github"
      Then I should see "https://github.com/"
