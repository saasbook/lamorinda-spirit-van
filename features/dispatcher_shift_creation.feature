Feature: Dispatcher Shift Creation

  As a dispatcher
  I want to manually create shifts for drivers
  So that I can manage shift assignments efficiently

  Background:
    Given I am on the "home" page

  Scenario: Dispatcher creates a new shift from calendar
    Given I am on the "Shifts Calendar" page
    Then I should see each day has a button for create a new shift
    When I click one day's "New shift" button
    Then I should be on the "New Shift" page
    And the date should initially be the date of the corresponding table
