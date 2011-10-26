Morale CLI
==========

Description
-----------

This gem allows you to create and manage Morale tickets from the command line. It contains a client application that communicates via 
the Morale API. You must have a valid API key on your profile in order to allow the API to have access to your accounts.

For more information about Morale see <http://teammorale.com>.

Setup
-----

	gem install morale
	
The first time you run a command, you will be prompted for your email address, password and a Morale account to work with. You can change the Morale account and project you would like to work with at any time. The account, project, and your API key is stored locally on your machine.

Available Commands
------------------

The same commands that are available on the web application are available within the CLI gem.

	morale login		# Asks for your email address and password for your Morale account and pulls down your API key
	morale accounts		# Displays a list of accounts for your email address and password
	morale projects		# Displays a list of projects for your current account
	morale tickets		# Displays a list of tickets for your current project
	morale [command]	# Creates, updates, or deletes a ticket based on your command.
	
	# Some sample ticket commands
	
	morale "This is a test task assign: Jamie due: today"	# Task with the title "This is a test task" assigned to Jamie W. with a due 				date of today
	morale "#35: assign: Robert"							# Updates ticket #35 by assigning it to Robert
	morale "a #2"											# Archives ticket #2
	morale "d #41"											# Deletes ticket #41
	
	** Ensure that you either escape the "#" character with \# or put the commands in quotes as a # is a comment character in the command line interface
	
Contributing
------------

1. Fork it.
2. Create a new branch.
3. Create tests for your changes.
4. Make your changes.
5. Run the tests.
6. Commit your changes.
7. Push your branch.
8. Create a pull request from your change.

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).

