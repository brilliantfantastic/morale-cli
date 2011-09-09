require 'rubygems'
require 'thor'
require "morale/client"

module Morale
  class Command < Thor
    
    desc "projects", "lists the projects available to the user"
    def projects
      i = 0
      Morale::Client.new("blah").projects.sort{|a,b| a['project']['name'] <=> b['project']['name']}.each do |record|
        puts "#{i += 1}. #{record['project']['name']}"
      end
    end
    
  end
end