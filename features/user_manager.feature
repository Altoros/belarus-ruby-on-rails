Feature: User management

  Scenario: as admin I can add admin rights for another user
    Given I have 2 users(1 of them is admin)
    And I am logged in with email "admin@example.com" and password "password"
    When I visit user_manager
    Then I should see "Make admin"
    When I click "Make admin"
    Then I should see "Remove admin"
    When I sign out
    And I am logged in with email "user@example.com" and password "password"
    And I visit user_manager
    Then I should see "UserManager"

  Scenario: as user I can't see user list
    Given I have 2 users(1 of them is admin)
    And I am logged in with email "user@example.com" and password "password"
    When I visit user_manager
    Then I should not see "UserManager"

  Scenario: as admin I can
    Given I have 2 users(1 of them is admin)
    And I am logged in with email "admin@example.com" and password "password"
    When I visit user_manager
    Then I should see "Make admin"
    When I click "Make admin"
    Then I should see "Remove admin"
