Feature: OmniAuth authorization via LinkedIn
  In order to get access to protected sections of the site
  As a user I should be able to sign in via external authorization provider LinkedIn

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without LinkedIn token could bind it
      When I follow "Bind with LinkedIn"
      Then I should see "http://www.linkedin.com/pub/"
