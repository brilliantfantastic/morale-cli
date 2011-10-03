Feature: Running the tickets command
  In order to view and create tickets
  As a command line user of Morale
  I should be able to run tickets to view, create, update, and delete tickets

  @interactive
  Scenario: Posting a ticket should return the ticket results
    Given a file named "credentials" with:
      """
      spartan
      12345
      1
      """
    When I run `morale ticket "task: This is a new task as: Jimmy"` interactively
    Then the output should contain:
      """
      Task
      """
    And the output should contain:
      """
      This is a new task
      """
    And the output should contain:
      """
      Jimmy P.
      """

  @interactive
  Scenario: Posting a ticket without a project should ask for a project
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale ticket "task: This is a new task as: Jimmy"` interactively
    Then the output should contain:
      """
      No project specified.
      """

  @interactive
  Scenario: Deleting a ticket should return the ticket results
    Given a file named "credentials" with:
      """
      spartan
      12345
      1
      """
    When I run `morale This should be deleted`
    And I run `morale "d #10"` interactively
    Then the output should contain:
      """
      This should be deleted
      """

  @interactive
  Scenario: Running tickets should return a list of all active tickets
    Given a file named "credentials" with:
      """
      spartan
      12345
      1
      """
    When I run `morale tickets` interactively
    Then the output should contain:
      """
      Task
      """
    And the output should contain:
      """
      Refactor user signup code
      """
    And the output should contain:
      """
      Create icon for list view
      """

  @interactive
  Scenario: Running tickets without a project should ask for a project
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale tickets` interactively
    Then the output should contain:
      """
      No project specified.
      """