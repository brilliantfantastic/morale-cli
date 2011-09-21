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

  @interactive
  Scenario: Running login with an invalid email address should display a message that the user is invalid
    When I run `morale login` interactively
    And I type "someone@somewhere-else.com"
    Then the output should contain:
      """
      Email is not registered.
      """

  @interactive
  Scenario: Choosing an invalid account id should display a message that the account is invalid
    When I run `morale login` interactively
    And I type "jimmy@example.com"
    And I type "9"
    Then the output should contain:
      """
      Invalid account.
      """

  @interactive
  Scenario: Choosing an invalid account id should allow for a retry
    When I run `morale login` interactively
    And I type "jimmy@example.com"
    And I type "9"
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
    Then the file "credentials" should contain "spartan"
    And the file "credentials" should contain "12345"