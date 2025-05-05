Feature: Manage Passengers

    As an admin or a dispatcher
    In order to track Passengers
    I want to be able to create, delete, update passenger records

    Background:
        Given a dispatcher is logged in

        Given the following passenger records exist:
            | Name        | Street           | City        | State | Zip   | Birthday   | Race | Hispanic? | Date Registered |
            | Jane Doe    | 123 Main St      | Lafayette   | CA    | 94549 | 1940-01-01 | 5    | true      | 2022-06-01      |
            | John Smith  | 456 Oak Rd       | Orinda      | CA    | 94550 | 1935-05-12 | 5    | false     | 2021-11-15      |
            | Mary Brown  | 789 Pine Ave     | Moraga      | CA    | 94551 | 1942-09-25 | 5    | true      | 2023-01-10      |
    
    @create 
    Scenario: Create a new passenger
        Given I am on the new passenger page
        When I fill in all necessary information
        And I press "Create Passenger"
        Then I should see "Passenger created."
    
    @edit
    Scenario: Edit an existing passenger
        Given I am on the master passenger list
        And I follow "Info" for "Jane Doe"
        When I fill in "Name" with "Jane Changed Doe"
        And I press "Update Passenger"
        Then I should see "Passenger updated."
        And I should see "Jane Changed Doe"
    
    @delete
    Scenario: Delete a passenger
        Given I am on the master passenger list
        And I follow "Delete" for "John Smith"
        Then I should not see "John Smith"
        And I should see "Passenger deleted."


