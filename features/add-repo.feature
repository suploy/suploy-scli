
Feature: Add a new repository

  Scenario Outline: Add a repository for a user who has an ssh key
		When I get repo add <user> <repo> for "suploy-scli"
		Then the ./gitolite.conf should contain <user> and <repo>

  Examples:
    | user    | repo		 |
    | flopska | mega		 |
    | flopska | project1 |
    | flopska | project2 |
    | user1		| project3 |
    | user1		| foobar	 |
    | user1		| dopeshit |
    

