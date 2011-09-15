Feature: User profile management


  Scenario: User can update his profile
    Given I am logged in
    When I follow "Edit profile"
    And I fill in "First name" with "Foo"
    And I fill in "Last name" with "Bar"
#   Got an email with verification code    
    And I should see "Ruby7"
    And I should see "7th"
    
    


