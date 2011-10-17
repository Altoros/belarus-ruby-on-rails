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

  Scenario: as admin I can cancel existing meetup
    Given I am logged in as admin
    And I come to meetups page and create meetup with topic "Belarus RoR meetup"
    When I follow "Cancel meetup"
    Then I should see "Meetup cancelled successfully"

  Scenario: as admin I can edit existing meetup
    Given I am logged in as admin
    And I come to meetups page and create meetup with topic "Belarus RoR meetup"
    When I follow "Edit meetup"
    And I fill in "Topic" with "Belarus RoR meetup 2"
    And I press "Save it!"
    Then I should see "Meetup updated successfully"
