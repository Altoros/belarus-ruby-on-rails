Feature: Github authorization without shared email
  In order to get access to protected sections of the site
  As a user I should be able to sign in via external authorization provider,
  but I can hide my email on public services or public services
  don't allow access to this information
    Background:
      Given I am on the homepage
      When I follow "Sign in with Github"
      Then I should see "Enter your email"

    @omniauth_test_without_email @omniauth_test_after
    Scenario: A user without shared email signs in with Github and enter email in application
      When I fill in "Email" with "example@example.com"
      And I press "Update"
      Then I should see "You will receive an email with instructions about how to confirm your account in a few minutes."
      And I should be signed out

    @omniauth_test_without_email @omniauth_test_after
    Scenario: A user without shared email signs in with Github and enter reserved email
      When I am a user named "foo" and surnamed "asd" with an email "user@test.com" and password "please"
      And I fill in "Email" with "user@test.com"
      And I press "Update"
      Then I should see "Email has already been taken"
      And I should be signed out
