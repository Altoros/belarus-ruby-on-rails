Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an email of "user@test.com"
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Invalid email or password."
      And I go to the home page
      And I should be signed out

    Scenario: User enters wrong password
      Given I am not logged in
      And I am signed up as a user
      When I go to the sign in page
      And I sign in as a user with wrong password
      Then I should see "Invalid email or password."
      And I go to the home page
      And I should be signed out

    Scenario: User signs in successfully with email
      Given I am not logged in
      And I am signed in as a user
      Then I should see "Signed in successfully"
      And I should be signed in
