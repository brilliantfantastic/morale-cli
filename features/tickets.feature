Feature: Running the tickets command
  In order to view and create tickets
  As a command line user of Morale
  I should be able to run tickets to view, create, update, and delete tickets

  @interactive
  Scenario: Running projects should not require authorization if the account and api key are stored
    Given a file named "credentials" with:
      """
      spartan
      12345
      1
      """
    When I run `morale ticket "task: This is a new task as: Jimmy"` interactively
    Then the output should contain:
      """
      task	This is a new task
      """