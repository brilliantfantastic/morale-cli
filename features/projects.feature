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
  Scenario: Running projects with the --change option should ask me to change the project
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale projects --change` interactively
    Then the output should contain:
      """
      Choose a project:
      """

  @interactive
  Scenario: Running projects with the --change option should save the current project
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale projects --change` interactively
    And I type "2"
    Then the file "credentials" should contain exactly:
      """
      spartan
      12345
      1

      """

  @interactive
  Scenario: Selecting an invalid project when running projects with the --change option should mention that there is an invalid project
    Given a file named "credentials" with:
      """
      spartan
      12345
      """
    When I run `morale projects --change` interactively
    And I type "9"
    Then the output should contain:
      """
      Invalid project.
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

  @interactive
  Scenario: Running project id should change the project
    Given a file named "credentials" with:
      """
      spartan
      12345
      1
      """
    When I run `morale project 1` interactively
    Then the file "credentials" should contain exactly:
      """
      spartan
      12345
      2

      """

  @interactive
  Scenario: Running project id with an invalid id should should mention that there is an invalid project
    Given a file named "credentials" with:
      """
      spartan
      12345
      1
      """
    When I run `morale project 9` interactively
    Then the output should contain:
      """
      Invalid project.
      """
    And the file "credentials" should contain exactly:
      """
      spartan
      12345
      1
      """