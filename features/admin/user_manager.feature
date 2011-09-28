Feature: Admin: User management
  Background:
    Given I have 2 users(1 of them is admin)

  Scenario: as admin I can add admin rights for another user
    Given I am logged in with email "admin@example.com" and password "password"
    When I visit admin/users
    Then I should see "Make admin"
    When I click "Make admin"
    Then I should see "Remove admin"
    When I sign out
    And I am logged in with email "user@example.com" and password "password"
    And I visit admin/users
    Then I should see "UserManager"

  Scenario: as user I can't see user list
    Given I am logged in with email "user@example.com" and password "password"
    When I visit admin/users
    Then I restricted to visit page

  Scenario: as admin I can
    Given I am logged in with email "admin@example.com" and password "password"
    When I visit admin/users
    Then I should see "Make admin"
    When I click "Make admin"
    Then I should see "Remove admin"

  Scenario: as admin I should see link to user management
    Given I am logged in with email "admin@example.com" and password "password"
    Then I should see "Control panel"

  Scenario: as user I should not see link to user management
    Given I am logged in with email "user@example.com" and password "password"
    Then I should not see "Control panel"
