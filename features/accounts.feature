Feature: Running the accounts command
  In order to view and select an account to work with
  As a command line user of Morale
  I should be able to run accounts to view available accounts and store my selected account information locally

  @interactive
  Scenario: Running accounts should not require an email address if the api key is stored
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale accounts` interactively
    Then the output should contain:
      """
      1. Spartan Design
      """

  @interactive
  Scenario: Running accounts without being authorized should ask for credentials
    Given a file named "credentials" with:
      """
      """
    And I run `morale accounts` interactively
    Then the output should contain:
      """
      Authentication failure
      """