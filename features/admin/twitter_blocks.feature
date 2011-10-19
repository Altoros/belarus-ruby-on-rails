Feature: Admin User management

  Scenario: as admin I can create and update twitter posts settings
    Given I am logged in as admin
    When I visit admin
    And I follow "Add new twitter block"
    And I fill in "Search" with "#hacby"
    And I press "Create"
    And I fill in "Search" with "from:melnikaite"
    And I press "Update"
    Then I should see "from:melnikaite"

  Scenario: as guest I can see block with tweets
    Given I am not logged in
    When I go to the home page
    Then I should see xpath //div[contains(@class, 'twtr-search-widget')]
