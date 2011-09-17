require 'rubygems'
require 'thor'
require "morale/client"

module Morale
  class Command < Thor
    
    desc "login", "signs a user in using their email address and password. Stores the users API key locally to use for access later."
    def login
    end
    
    desc "accounts", "gets all the subdomains available for a given email address."    
    def accounts(email)
      i = 0
      Morale::Command.client.accounts(email).sort{|a,b| a['account']['group_name'] <=> b['account']['group_name']}.each do |record|
        puts "#{i += 1}. #{record['account']['group_name']}"
      end
    end
    
    desc "projects", "lists the projects available to the user."
    def projects
      i = 0
      begin
        #TODO: Handle 404
        Morale::Command.client.projects.sort{|a,b| a['project']['name'] <=> b['project']['name']}.each do |record|
          puts "#{i += 1}. #{record['project']['name']}"
        end
      rescue Morale::Client::Unauthorized
        puts "Authentication failure"
        #TODO: Try to login
        #run "login"
        #retry
      end
    end
    
    class << self
      def client
        #TODO: Where do I get the subdomain? Where do I get the api_key?
        #Morale::Auth.client
        Morale::Client.new("blah")
      end
    end
    
  end
end