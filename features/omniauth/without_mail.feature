Feature: Social Network authorization without shared email
  In order to get access to protected sections of the site
  As as User
  I should be able to sign in via external authorization provider,
  but he can hide his email on public services or public services
  don't allow access to this information
    Background:
      Given there is Ruby on Rails level "Expert"
      And I am on the login page

    @omniauth_test_without_email @omniauth_test_after
    Scenario Outline: A user without shared email signs in and enters email in application
      Given I follow "Sign in with <provider>"
      When I fill in "Email" with "example@example.com"
      And I select "Expert" from "Ruby on Rails level"
      And I press "Create"
      Then I should see "You will receive an email with instructions about how to confirm your account in a few minutes."
      And I should be signed out

      Examples: providers
        | provider    |
        | Facebook    |
        | Github      |
        | Vkontakte   |
        | Twitter     |
        | Linked In   |

    @omniauth_test_without_email @omniauth_test_after
    Scenario Outline: A user without shared email signs in and enters reserved email
      Given I am a user named "foo" and surnamed "asd" with an email "user@test.com" and password "please" with Ruby on Rails level "Expert"
      When I follow "Sign in with <provider>"
      And I fill in "Email" with "user@test.com"
      And I select "Expert" from "Ruby on Rails level"
      And I press "Create"
      Then I should see "Email has already been taken"
      And I should be signed out

      Examples: providers
        | provider    |
        | Facebook    |
        | Github      |
        | Vkontakte   |
        | Twitter     |
        | Linked In   |

    @omniauth_test_without_email @omniauth_test_after
    Scenario Outline: User doesn't set his Ruby on Rails level
      Given I follow "Sign in with <provider>"
      When I fill in "Email" with "example@example.com"
      And I press "Create"
      Then I should see "Ruby on Rails level can't be blank"

      Examples: providers
        | provider    |
        | Facebook    |
        | Github      |
        | Vkontakte   |
        | Twitter     |
        | Linked In   |
