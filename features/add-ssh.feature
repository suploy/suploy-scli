Feature: Add an ssh key through suploy-webapp

  Scenario Outline: Add a valid ssh key for a valid user
    When I run the "suploy-scli" with ssh add <user> <keyname> <key>
    Then the key should be in /home/vagrant/gitolite-admin/keydir/<user>@<keyname>.pub

  Examples:
    | user    | keyname | key |
    | flopska | home    | "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwawHJS9oKMVEjp3L9DlbX0HI8Gf934epCSPRsfsTt3wLXDKqBgUU8KgVpP2qMX40hSimYoBkhrR251RSnZC3sDl2xDMJb33M9bVk0fkzKO/I0Ip6wpGeiXcRL6C0lBRhIuwIf6KkDbsWU57VU4Le20mNLwqNeu8OnA1+V6zbZZMknZYz+bH0aZMIzc5Kn1MzLr/OrPrwrXT9dw1FhDqBewxByg2eq+AFXI4av05przmdripZRBxR6oi+AN1C8EV7nALVdgMQZ9IiCxA5DRFNw2JzrZaxP0gVKWf5m35t13x7i/6m1MFdPXO5F2+zq/W5UwzGoeCtsV+0+EFbM46LF vagrant@suploy" |
    | flopska | ubuntu  | "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDk4XGs0tSxU67iRYqZsgXRemwfqx34ho8E/KMra8QtApFSP69Xg0GwBDMlqzn6D8VZX6VDimzZZxbJwJ/9YEbxKFN/MvVtfOd7NafYM4iea3ATEoqFTX2V3Yb3LzFiwMRLz0fn/qeZ2mX1X1++vzaFcQHQ2Az6iE1ELlKYyz1+x1XJm8eqiHigksrR5oZtzpU/xRRwpKKMD3yby7oVEdNrY4LZXgUGL4Y4I680dWgof7MNCYdk8TeapGekNPCjL/Xhgvo2d84s1yBzHNEJuicSgbvOfSsLxRa+92QjRDNrgf9SfJInN2cRbKm7wKKd01D3gApbZHx6UH5nKSdg515F vagrant@suploy" |
    | flopska | windows | "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsBrhpd124g6JzhDGfWUBEdwmZJKa3S75MxnrILl+QN2+7Xwbp3xvQs/2cgGU72OreA0zJ5topX7FRzqLVfHzCT/A/MXdnQ+8hcJUPTX7nS0jzt31q2Yo4abg/IhMo8xrkwMhNhSolP2cAK6FaBVHr6z24Cyl4GwGw5kzdszKMbeCgkUHDFdHE4bBj6KCP7psszzZvriRfWGs8IYEdvBbRAZaJHvXzaIWMx45tHopFO9sZicSjbMojGi+NmMGt6RkIMOWUrvprzghsbH9U6Kvpi2sNJE4ODerNoKg7Fq4auUMRA/sP4n40XJ3O5beb/1SIfvO6sbT0q26ECYDOTx+l vagrant@suploy" |
    

