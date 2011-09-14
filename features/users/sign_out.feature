Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I am a user named "foo" and surnamed "asd" with an email "user@test.com" and password "please"
      When I sign in as "user@test.com/please"
      Then I should be signed in
      And I sign out
      When I return next time
      Then I should be signed out
