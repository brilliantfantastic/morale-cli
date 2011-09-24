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
  Scenario: Running accounts with the --change option should ask me to change the account
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale accounts --change` interactively
    Then the output should contain:
      """
      Choose an account:
      """

  @interactive
  Scenario: Selecting an invalid account when running accounts with the --change option should mention that there is an invalid account
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale accounts --change` interactively
    And I type "9"
    Then the output should contain:
      """
      Invalid account.
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

  @interactive
  Scenario: Running account id should change the account
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale account 2` interactively
    Then the file "credentials" should contain exactly:
      """
      wolverine
      12345

      """

  @interactive
  Scenario: Running account id with an invalid id should should mention that there is an invalid account
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale account 9` interactively
    Then the output should contain:
      """
      Invalid account.
      """
    And the file "credentials" should contain exactly:
      """
      spartan
      12345
      """