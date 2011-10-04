Feature: Admin User management
  Background:
    Given I have 2 users(1 of them is admin)

  Scenario: as admin I have access to dashboard
    Given I am logged in with email "admin@example.com" and password "password"
    When I visit admin
    Then I should see "Dashboard"

  Scenario: as user I haven't access to dashboard
    Given I am logged in with email "user@example.com" and password "password"
    When I visit admin
    Then I restricted to visit page
