Feature: Add an ssh key through suploy-webapp

  Scenario Outline: Add a valid ssh key for a valid user
    Given I run the script with add-ssh <user> <keyname> "some-key"
    Then the key should be in "keys/keydir/"<keydir>

  Examples:
    | user    | keyname | keydir              |
    | flopska | home    | flopska@home.pub    |
    | flopska | ubuntu  | flopska@ubuntu.pub  |
    | flopska | windows | flopska@windows.pub |
    

