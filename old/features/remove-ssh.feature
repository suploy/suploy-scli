
Feature: Remove an SSH Key through suploy webapp

  Scenario Outline: Remove an ssh key from a user
    Given I run the script with rm-ssh --user <user> --keyname <keyname>
    Then the key should not be in "<keydir>"/<user>@<keyname>.pub

  Examples:
    | user    | keyname | keydir |
    | flopska | home    | ./     |
    | flopska | ubuntu  | ./     |
    | flopska | windows | ./     |
    

