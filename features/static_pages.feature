Feature: Custom news management

  Scenario: Visitor can read "About" page
    Given static page "about" exists
    When I go to About page
    Then I should see "About"

  Scenario: Visitor can see static pages links
    Given static page "about" exists
    And I am on the articles page
    Then I should see "About"

  Scenario: Visitor can't edit static page
    Given static page "about" exists
    And I am not logged in
    And I am on the articles page
    When I go to About page
    Then I should not see "Edit"

  Scenario: Admin can add static page
    Given I am logged in as admin
    When I visit admin
    And I follow "manage static pages"
    And I follow "New static page"
    And I fill in "Title" with "Contacts"
    And I fill in "Permalink" with "Contacts"
    And I fill in "Content" with "Just whistle!"
    And I press "Create"
    Then I should see "The page was successfully created"

  Scenario: Admin can edit static page
    Given static page "about" exists
    And I am logged in as admin
    When I go to About page
    And I follow edit static page for "About"
    And I fill in "Title" with "About"
    And I fill in "Content" with "We are still the champions, dude!"
    And I press "Update"
    Then I should see "The page was successfully updated"

  Scenario: Admin can delete static page
    Given static page "about" exists
    And I am logged in as admin
    When I visit admin
    And I follow "manage static pages"
    And I follow "Delete"
    Then I should see "The page was successfully deleted"
