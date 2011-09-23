require 'morale/client'
require 'morale/command'
require 'morale/authorization'

module Morale::Commands
  class Project
    class << self
      include Morale::Platform
      
      def list
        begin
          projects = Morale::Command.client.projects
          if !projects.nil?
            projects.sort{|a,b| a['project']['name'] <=> b['project']['name']}.each_with_index do |record, i|
              puts "#{i += 1}. #{record['project']['name']}"
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
      
    end
  end
end