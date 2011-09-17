require 'rubygems'
require 'thor'
require 'morale/client'
require 'morale/authorization'

module Morale
  class Command < Thor
    
    desc "login", "signs a user in using their email address and password. Stores the users API key locally to use for access later."
    def login
      Morale::Authorization.login
    end
    
    desc "accounts", "gets all the subdomains available for a given email address."    
    def accounts(email)
      Morale::Command.client.accounts(email).sort{|a,b| a['account']['group_name'] <=> b['account']['group_name']}.each_with_index do |record, i|
        puts "#{i += 1}. #{record['account']['group_name']}"
      end
    end
    
    desc "projects", "lists the projects available to the user."
    def projects
      begin
        #TODO: Handle 404
        Morale::Command.client.projects.sort{|a,b| a['project']['name'] <=> b['project']['name']}.each_with_index do |record, i|
          puts "#{i += 1}. #{record['project']['name']}"
        end
      rescue Morale::Client::Unauthorized
        puts "Authentication failure"
        login
        retry if Morale::Authorization.retry_login?
      end
    end
    
    class << self
      def client
        Morale::Authorization.client
      end
    end
    
  end
end