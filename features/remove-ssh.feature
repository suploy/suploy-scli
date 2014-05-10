
Feature: Remove an SSH Key through suploy webapp

  Scenario Outline: Remove an ssh key from a user
    When I run the "suploy-scli" with ssh rm <user> <keyname> 
    Then the key should not be in /home/vagrant/gitolite-admin/keydir/<user>@<keyname>.pub

  Examples:
    | user    | keyname | 
    | flopska | home    |
    | flopska | ubuntu  | 
    | flopska | windows |
