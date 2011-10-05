Feature: Admin: Meetup management
  Background:
    Given I have 2 users(1 of them is admin)

  Scenario: as admin I can see meetup page
    Given I am logged in with email "admin@example.com" and password "password"
    When I visit admin/meetups
    Then I should see "Meetup"

  Scenario: as admin I can create meetup
    Given I am logged in with email "admin@example.com" and password "password"
    And I visit admin/meetups/new
    When I fill in "Topic" with "New RoR Meetup"
    And I fill in "Description" with "Meetup description"
    And I fill in "Place" with "Belarus, Minsk"
    And I select "2007-11-11 10:00" as the "Date and time" date
    And I press "Save it !"
    Then I should see "Date and time must be in future"

  Scenario: as admin I can create meetup
    Given I am logged in with email "admin@example.com" and password "password"
    And I visit admin/meetups/new
    When I fill in "Topic" with "New RoR Meetup"
    And I fill in "Description" with "Meetup description"
    And I fill in "Place" with "Belarus, Minsk"
    And I select "2015-11-11 10:00" as the "Date and time" date
    And I press "Save it !"
    Then I should see "Meetup created successfully"
