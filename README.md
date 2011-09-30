Morale CLI
==========

Description
-----------

This gem allows you to create and manage Morale tickets from the command line. It contains a client application that communicates via 
the Morale API. You must have the API enabled on the account you wish to work with (which is turned off by default) and a valid API key.

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
	morale [command]	# Creates, updates, or deletes a ticket based on your command.
	
	# Some sample ticket commands
	
	morale This is a test task assign: Jamie due: today		# Task with the title "This is a test task" assigned to Jamie W. with a due 				date of today
	morale #35: assign: Robert								# Updates ticket #35 by assigning it to Robert
	morale a #2												# Archives ticket #2
	morale d #41											# Deletes ticket #41


Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).

