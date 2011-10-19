Feature: Admin User management

  Scenario: as admin I can update twitter posts settings
    Given I am logged in as admin
    When I visit admin
    And I follow "Edit twitter posts settings"
    And I fill in "Search" with "#hacby"
    And I press "Update"
    Then I should see "#hacby"

  Scenario: as guest I can see block with tweets
    Given I am not logged in
    When I go to the home page
    Then I should see xpath //div[contains(@id, 'twtr-search-widget')]
