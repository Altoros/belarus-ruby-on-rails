Feature: OmniAuth authorization via Social Networks
  In order to get access to protected sections of the site
  As a User
  I should be able to sign in via external authorization provider

    Background:
      Given there is Ruby on Rails level "Expert"
      Given I am not logged in
      And I am on the homepage

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: A user signs in successfully
      Given I follow "Sign in with <provider>"
      When I select "Expert" from "Ruby on Rails level"
      And I press "Create"
      Then I should see "Logout"

      Examples: providers
        | provider   |
        | Facebook   |
        | Github     |
        | Vkontakte  |
        | Twitter    |
        | GoogleApps |
        | LinkedIn   |

    @omniauth_test_failure @omniauth_test_after
    Scenario Outline: A user signs in unsuccessfully
      When I follow "Sign in with <provider>"
      Then I should see "Could not authorize you from <name> because"

      Examples: providers
        | provider   | name        |
        | Facebook   | Facebook    |
        | Github     | Github      |
        | Vkontakte  | Vkontakte   |
        | Twitter    | Twitter     |
        | GoogleApps | Google apps |
        | LinkedIn   | Linked in   |

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: A user after successfull sign in returns to the same page
      Given I come to article page with name "Very specific article 911"
      When I follow "Sign in with <provider>"
      When I select "Expert" from "Ruby on Rails level"
      And I press "Create"
      Then I should see "Very specific article 911"

      Examples: providers
        | provider   |
        | Facebook   |
        | Github     |
        | Vkontakte  |
        | Twitter    |
        | GoogleApps |
        | LinkedIn   |

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: A user previously registered by email successfully signs in
      Given I am a user named "Name" and surnamed "Surname" with an email "user@test.com" and password "please" with Ruby on Rails level "Expert"
      And  I follow "Sign in with <provider>"
      When I follow "Edit registration"
      Then I should see "Current password"

      Examples: providers
        | provider   |
        | Facebook   |
        | Github     |
        | Vkontakte  |
        | Twitter    |
        | GoogleApps |
        | LinkedIn   |

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: A user never registered before successfully signs in
      Given I follow "Sign in with <provider>"
      And I select "Expert" from "Ruby on Rails level"
      And I press "Create"
      When I follow "Edit registration"
      Then I should see "Reset my password"

      Examples: providers
        | provider   |
        | Facebook   |
        | Github     |
        | Vkontakte  |
        | Twitter    |
        | GoogleApps |
        | LinkedIn   |

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: User doesn't set his Ruby on Rails level
      Given I follow "Sign in with <provider>"
      When I press "Create"
      Then I should see "Profile experience can't be blank"

      Examples: providers
        | provider   |
        | Facebook   |
        | Github     |
        | Vkontakte  |
        | Twitter    |
        | GoogleApps |
        | LinkedIn   |

    @omniauth_test_success @omniauth_test_after
    Scenario Outline: User can subscribe to news mailer
      When I follow "Sign in with <provider>"
      Then I should see "Receive news E-mails"

      Examples: providers
        | provider   |
        | Facebook   |
        | Github     |
        | Vkontakte  |
        | Twitter    |
        | GoogleApps |
        | LinkedIn   |
