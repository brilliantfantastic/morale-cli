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
    
    desc "accounts ID", "Changes the current account to the numeric identifier of the account specified."    
    def account(id)
      Morale::Commands::Account.select id
    end
    
    desc "projects", "Lists the projects available to the user and the current account."
    method_options :change => false
    def projects
      Morale::Commands::Project.list options.change
    end
    
    desc "projects ID", "Changes the current project to the numeric identifier of the project specified."    
    def project(id)
      Morale::Commands::Project.select id
    end
    
    class << self
      def client
        Morale::Authorization.client
      end
    end
    
  end
end