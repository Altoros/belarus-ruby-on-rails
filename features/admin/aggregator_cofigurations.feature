Feature: Aggregator settings management

  Scenario: as admin I can update aggregator settings
    Given I am logged in as admin
    When I visit admin
    And I follow "Edit aggregator settings"
    And I fill in "Source" with "MySource"
    And I press "Update"
    And I follow "Edit aggregator settings"
    Then I should see "MySource"
