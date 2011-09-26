Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I am logged in as user
      Then I should be signed in
      And I sign out
      When I return next time
      Then I should be signed out
