
Feature: Delete a repository

  Scenario Outline: Remove a previously created repository
		Given I run the script with rm-repo --repo <repo>
		Then the ./gitolite.conf should not contain <repo>

  Examples:
    | repo     |
    | project1 |
    | project2 |
    | project3 |
    
