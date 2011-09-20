Feature: Running the login command
  In order to set the current user's authentication information
  As a command line user of Morale
  I should be able to run login to store my authentication information locally

  @interactive
  Scenario: Running login should ask for the account information
    When I run `morale login` interactively
    Then the output should contain:
      """
      No account specified for Morale.
      """

  @interactive
  Scenario: Running login should display account information in a list
    When I run `morale login` interactively
    And I type "jimmy@example.com"
    Then the output should contain:
      """
      1. Spartan Design
      Choose an account:
      """

  Scenario: Running login successfully to store my authentication information
    When I run `morale login` interactively
    And I type "jimmy@example.com"
    And I type "1"
    And I type "test"
    #Put the credentials file location in a config
    #Then a file named "~/.morale/credentials" should exist
    #Then the file "/.morale/credentials" should contain "spartan"