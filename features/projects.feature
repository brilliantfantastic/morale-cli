Feature: Running the projects command
  In order to view and select a project to work with
  As a command line user of Morale
  I should be able to run projects to view available projects and store my selected project information locally

  @interactive
  Scenario: Running projects should not require authorization if the account and api key are stored
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale projects` interactively
    Then the output should contain:
      """
      1. Skunk Works
      2. Spin Free Project
      """

  @interactive
  Scenario: Running projects without being authorized should ask for credentials
    Given a file named "credentials" with:
      """
      """
    And I run `morale projects` interactively
    Then the output should contain:
      """
      Authentication failure
      """