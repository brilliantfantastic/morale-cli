require 'rubygems'
require 'thor'
require 'morale/commands/account'
require 'morale/commands/authorization'
require 'morale/commands/project'

module Morale
  class Command < Thor
    include Morale::Platform
    
    desc "login", "Signs a user in using their email address and password. Stores the users API key locally to use for access later."
    def login
      Morale::Commands::Authorization.login
    end
    
    desc "accounts [EMAIL]", "Gets all the subdomains available for a given email address if provided, else it uses the current api key."    
    method_options :change => false
    def accounts(email="")
      Morale::Commands::Account.list email, options.change
    end
    
    desc "projects", "Lists the projects available to the user and the current account."
    method_options :change => false
    def projects
      Morale::Commands::Project.list options.change
    end
    
    class << self
      def client
        Morale::Authorization.client
      end
    end
    
  end
end