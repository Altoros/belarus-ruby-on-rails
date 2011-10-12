Feature: Admin: User management

  Scenario: as admin I have access to dashboard
    Given I am logged in as admin
    When I visit admin
    Then I should see "Dashboard"

  Scenario: as user I haven't access to dashboard
    Given I am logged in as user
    When I visit admin
    Then I restricted to visit page
