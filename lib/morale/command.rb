require 'rubygems'
require 'thor'
require 'morale/commands/account'
require 'morale/commands/authorization'
require 'morale/commands/project'
require 'morale/commands/ticket'

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
    
    desc "ticket COMMAND", "Creates, updates, or deletes a ticket based on the command specified."
    method_option :command, :aliases => "-c", :type => :array, :desc => "Specify -c without putting the parameter in a string"
    def ticket(command="")
      if command.empty? && !options[:command].nil?
        command = options[:command].compact.join(" ")
      end
      Morale::Commands::Ticket.command command
    end
    
    class << self
      def client
        Morale::Authorization.client
      end
    end
    
    no_tasks do
      def self.handle_no_task_error(task, has_namespace = $thor_runner) #:nodoc:
        self.new.ticket ARGV.compact.join(" ")
      end
    end
    
  end
end