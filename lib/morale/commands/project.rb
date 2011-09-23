require 'morale/client'
require 'morale/command'
require 'morale/authorization'

module Morale::Commands
  class Project
    class << self
      
      def list
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
          Morale::Commands::Authorization.login
          retry if Morale::Authorization.retry_login?
        rescue Morale::Client::NotFound
          $stdout.puts "Communication failure"; $stdout.flush
        end
      end
      
    end
  end
end