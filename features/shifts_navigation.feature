Feature: Navigation from Homepage to Shifts Calendar

  Scenario: User navigates from "homepage" to "Today's Rides"
    Given I am on the "homepage" page
    When I click on "Today's Rides" button
    Then I should be on the "Today's Rides" page
    
  Scenario: User navigates from "Today's Rides" to "Read-Only Shift Calendar"
    Given I am on the "Today's Rides" page
    Then I should see "View Shifts" button
    When I click on "View Shifts" button
    Then I should be on the "Read-Only Shift Calendar" page

  Scenario: User click button to switch month
    Given I am on the "Read-Only Shift Calendar" page
    Then I should see the current month and year in the calendar title
    And I should see "Last Month" "Jump to Today" "Next Month" button
    When I note the current month title
    When I click on "Last Month" button
    Then I should see the month title change
    When I click on "Jump to Today" button
    Then I should see the current month title again
    When I click on "Next Month" button
    Then I should see the month title change

