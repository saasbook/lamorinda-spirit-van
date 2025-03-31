Feature: Driver Ride and Shift Navigation

  As a driver
  I want to view my rides and shifts
  So that I can review my schedule efficiently

  Background:
    Given I am on the "home" page

  Scenario: Navigating from Home to Today's Rides
    When I click on "Today's Rides" button
    Then I should be on the "Today's Rides" page

  Scenario: Viewing monthly shifts from Today's Rides
    Given I am on the "Today's Rides" page
    Then I should see "View Shifts" button
    When I click on "View Shifts" button
    Then I should be on the "Read-Only Shift Calendar" page

  Scenario: Viewing the current month in the shift calendar
    Given I am on the "Read-Only Shift Calendar" page
    Then I should see the current month and year in the calendar title

  Scenario: Driver can switch month
    Given I am on the "Read-Only Shift Calendar" page
    Then I should see "Last Month" "Jump to Today" "Next Month" button
    When I note the current month title
    When I click on "Last Month" button
    Then I should see the month title change
    When I click on "Jump to Today" button
    Then I should see the current month title again
    When I click on "Next Month" button
    Then I should see the month title change
