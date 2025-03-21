Scenario: User clicks button to check driver's shifts
  Given I am on the "Shifts Calendar" page
  Then I should see each day has a "New shift" button
  When I click a "New shift" button
  Then I should be on the "New Shift" page
  When I fill in the new shift form with valid data
  And I submit the shift form
  Then I should see the shift record in the corresponding block
  When I click on the driver's name
  Then I should see a page listing all shifts for that driver
  When I click on the shift type
  Then I should see the shift detail page