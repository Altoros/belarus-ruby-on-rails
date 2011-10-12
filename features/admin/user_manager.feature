Feature: Admin: User management

  Scenario: Admin can add admin rights to another user
    Given I am logged in as admin
    And I have 1 user
    When I visit admin/users
    And I click "Make admin"
    Then I should see "Remove admin"

  Scenario: User can't see user list
    Given I am logged in as user
    When I visit admin/users
    Then I restricted to visit page

  Scenario: Admin should see link to user management
    Given I am logged in as admin
    Then I should see "Control panel"

  Scenario: User should not see link to user management
    Given I am logged in as user
    Then I should not see "Control panel"
