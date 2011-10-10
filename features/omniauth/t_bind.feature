Feature: OmniAuth authorization via Twitter
  In order to get access to protected sections of the site
  As a user I should be able to sign in via external authorization provider Twitter

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without Twitter token could bind it
      When I follow "Bind with Twitter"
      Then I should see "http://twitter.com/#!/"
