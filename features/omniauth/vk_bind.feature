Feature:
  OmniAuth authorization via Vkontakte
  In order to get access to protected sections of the site
  A user
  Should be able to sign in via external authorization provider Vkontakte

    Background:
      Given I am logged in as user
      And I follow "Edit profile"
      And I follow "Show"

    @omniauth_test_success @omniauth_test_after
    Scenario: A signed user without Vkontakte token could bind it
      When I follow "Bind with Vkontakte"
      Then I should see "http://vkontakte.ru/"
