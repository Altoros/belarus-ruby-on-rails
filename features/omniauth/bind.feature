Feature: OmniAuth authorization via Social Network accounts
  In order to get access to protected sections of the site
  As a User
  I should be able to sign in via external authorization providers

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: A signed user without Social Network token could bind it
      When I follow "Bind with <provider>"
      Then I should see "<expectation>"

      Examples: providers
        | provider   | expectation                         |
        | Facebook   | http://www.facebook.com/profile.php |
        | GoogleApps | user@test.com                       |
        | Vkontakte  | http://vkontakte.ru/                |
        | Twitter    | http://twitter.com/#!/              |
        | Github     | https://github.com/                 |
