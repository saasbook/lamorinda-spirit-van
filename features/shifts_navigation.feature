Feature: Navigation from Homepage to Shifts Calendar

  Scenario: User navigates from "homepage" to "Today's Rides"
    Given I am on the "homepage"
    When I click on "Today's Rides" button
    Then I should be on the "Today's Rides" page
    
  Scenario: User navigates from "Today's Rides" to "Read-Only Shift Calendar"
    Given I am on the "Today's Rides" page
    Then I should see "View Shifts" button
    When I click on "View Shifts" button
    Then I should be on the "Read-Only Shift Calendar" page

