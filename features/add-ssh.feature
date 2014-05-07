Feature: Add an ssh key through suploy-webapp

  Scenario Outline: Add a valid ssh key for a valid user
    Given I run the script with ssh add <user> <keyname> "some-key"
    Then the key should be in "<keydir>"/<user>@<keyname>.pub

  Examples:
    | user    | keyname | keydir |
    | flopska | home    | ./     |
    | flopska | ubuntu  | ./     |
    | flopska | windows | ./     |
    

