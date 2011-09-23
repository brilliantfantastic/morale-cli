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
    
    desc "accounts EMAIL(optional)", "gets all the subdomains available for a given email address if provided, else it uses the current api key."    
    def accounts(email="")
      accounts = Morale::Client.accounts(email) unless email.blank?
      
      begin
        accounts = Morale::Command.client.accounts if email.blank?

        if !accounts.nil?
          accounts.sort{|a,b| a['account']['group_name'] <=> b['account']['group_name']}.each_with_index do |record, i|
            $stdout.puts "#{i += 1}. #{record['account']['group_name']}"; $stdout.flush
          end
        else
          $stdout.puts "There were no accounts found."; $stdout.flush
        end
      rescue Morale::Client::Unauthorized, Morale::Client::NotFound
        $stdout.puts "Authentication failure"; $stdout.flush
        login
        retry if Morale::Authorization.retry_login?
      end
    end
    
    desc "projects", "lists the projects available to the user."
    def projects
      begin
        projects = Morale::Command.client.projects
        if !projects.nil?
          projects.sort{|a,b| a['project']['name'] <=> b['project']['name']}.each_with_index do |record, i|
            puts "#{i += 1}. #{record['project']['name']}"
          end
        else
          $stdout.puts "There were no projects found."; $stdout.flush
        end
      rescue Morale::Client::Unauthorized
        $stdout.puts "Authentication failure"; $stdout.flush
        login
        retry if Morale::Authorization.retry_login?
      rescue Morale::Client::NotFound
        $stdout.puts "Communication failure"; $stdout.flush
      end
    end
    
    class << self
      def client
        Morale::Authorization.client
      end
    end
    
  end
end