require 'morale/client'
require 'morale/command'
require 'morale/authorization'

module Morale::Commands
  class Project
    class << self
      include Morale::IO
      
      def list(change=false)
        begin
          projects = Morale::Command.client.projects
          if !projects.nil?
            projects.sort{|a,b| a['project']['name'] <=> b['project']['name']}.each_with_index do |record, i|
              puts "#{i += 1}. #{record['project']['name']}#{' *' if Morale::Account.project(false) == record['project']['id'].to_s}"
            end
            
            if change
              say "Choose a project: "
              index = ask
              project = projects[index.to_i - 1]
              
              if project.nil?
                say "Invalid project."
              end
              Morale::Account.project = project['project']['id'] unless project.nil?
            end
          else
            say "There were no projects found."
          end
        rescue Morale::Client::Unauthorized
          say "Authentication failure"
          Morale::Commands::Authorization.login
          retry if Morale::Authorization.retry_login?
        rescue Morale::Client::NotFound
          say "Communication failure"
        end
      end
      
      def select(id)
        begin
          projects = Morale::Command.client.projects
          if !projects.nil?
            project = projects[id.to_i - 1]
            if project.nil?
              say "Invalid project."
            end
            Morale::Account.project = project['project']['id'] unless project.nil?
          else
            say "There were no projects found."
          end
        rescue Morale::Client::Unauthorized
          say "Authentication failure"
          Morale::Commands::Authorization.login
          retry if Morale::Authorization.retry_login?
        rescue Morale::Client::NotFound
          say "Communication failure"
        end
      end
      
    end
  end
end