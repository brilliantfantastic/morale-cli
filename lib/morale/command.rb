require 'rubygems'
require 'thor'
require 'morale/commands/account'
require 'morale/commands/authorization'
require 'morale/commands/project'

module Morale
  class Command < Thor
    
    desc "login", "signs a user in using their email address and password. Stores the users API key locally to use for access later."
    def login
      Morale::Commands::Authorization.login
    end
    
    desc "accounts EMAIL(optional)", "gets all the subdomains available for a given email address if provided, else it uses the current api key."    
    def accounts(email="")
      Morale::Commands::Account.list email
    end
    
    desc "projects", "lists the projects available to the user."
    def projects
      Morale::Commands::Project.list
    end
    
    class << self
      def client
        Morale::Authorization.client
      end
    end
    
  end
end