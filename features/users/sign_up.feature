Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given there is Ruby on Rails level "Expert"
      And I am not logged in
      And I go to the sign up page

    Scenario: User signs up with valid data
      And I fill in the following:
        | Email                 | user@test.com   |
        | First name            | Testy           |
        | Last name             | McUserton       |
        | Password              | please          |
        | Password confirmation | please          |
      And I select "Expert" from "Ruby on Rails level"
      And I press "Sign up"
      Then I should see "You have signed up successfully."
      
    Scenario: User signs up with invalid email
      And I fill in the following:
        | Email                 | invalidemail    |
        | First name            | Testy           |
        | Last name             | McUserton       |
        | Password              | please          |
        | Password confirmation | please          |
      And I select "Expert" from "Ruby on Rails level"
      And I press "Sign up"
      Then I should see "Email is invalid"

    Scenario: User signs up without password
      And I fill in the following:
        | Email                 | user@test.com   |
        | First name            | Testy           |
        | Last name             | McUserton       |
        | Password              |                 |
        | Password confirmation | please          |
      And I select "Expert" from "Ruby on Rails level"
      And I press "Sign up"
      Then I should see "Password can't be blank"

    Scenario: User signs up without password confirmation
      And I fill in the following:
        | Email                 | user@test.com   |
        | First name            | Testy           |
        | Last name             | McUserton       |
        | Password              | please          |
        | Password confirmation |                 |
      And I select "Expert" from "Ruby on Rails level"
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

    Scenario: User signs up with mismatched password and confirmation
      And I fill in the following:
        | Email                 | user@test.com   |
        | First name            | Testy           |
        | Last name             | McUserton       |
        | Password              | please          |
      And I select "Expert" from "Ruby on Rails level"
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

    Scenario: User signs up without setting Ruby on Rails level
      And I fill in the following:
        | Email                 | user@test.com   |
        | First name            | Testy           |
        | Last name             | McUserton       |
        | Password              | please          |
        | Password confirmation | please          |
      And I press "Sign up"
      Then I should see "Ruby on Rails level can't be blank"
