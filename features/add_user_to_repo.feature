
Feature: Add a new repository

  Scenario Outline: Add a repository for a user who has an ssh key
		When I get repo user add <repo> <user> for "suploy-scli"
		Then the ./gitolite.conf should contain <user> and <repo>

  Examples:
    | user    | repo		 |
    | flopska2 | mega		 |
    | flopska4 | mega		 |
