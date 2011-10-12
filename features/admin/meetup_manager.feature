Feature: Admin: Meetup management
  Scenario: as admin I can see meetup page
    Given I am logged in as admin
    When I visit admin/meetups
    Then I should see "Meetup"

  Scenario: as admin I can create meetup
    Given I am logged in as admin
    And I visit admin/meetups/new
    When I fill in "Topic" with "New RoR Meetup"
    And I fill in "Description" with "Meetup description"
    And I fill in "Place" with "Belarus, Minsk"
    And I select "2007-11-11 10:00" as the "Date and time" date
    And I press "Save it!"
    Then I should see "Date and time must be in future"

  Scenario: as admin I can create meetup
    Given I am logged in as admin
    And I visit admin/meetups/new
    When I fill in "Topic" with "New RoR Meetup"
    And I fill in "Description" with "Meetup description"
    And I fill in "Place" with "Belarus, Minsk"
    And I select "2015-11-11 10:00" as the "Date and time" date
    And I press "Save it!"
    Then I should see "Meetup created successfully"
