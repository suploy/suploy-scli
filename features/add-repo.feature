
Feature: Add a new repository

  Scenario Outline: Add a repository for a user who has an ssh key
		Given I run the script with add-repo --user <user> --repo <repo>
		Then the gitolite conf should contain <user> and <repo>

  Examples:
    | user    | repo		 |
    | flopska | project1 |
    | flopska | project2 |
    | user1		| project3 |
    

