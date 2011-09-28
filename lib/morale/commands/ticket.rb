require 'morale/client'
require 'morale/command'
require 'morale/authorization'
require 'hirb'

module Morale::Commands
  class Ticket
    class << self
      include Morale::Platform
      
      def command(command)
        ticket = Morale::Command.client.ticket Morale::Account.project, command
        print ticket
      end
      
      private
      
      def print(ticket)
        due_date = Date.parse(ticket['due_date']).strftime("%b. %d") unless ticket['due_date'].nil?
        assigned_to = "#{ticket['assigned_to']['user']['first_name']} #{(ticket['assigned_to']['user']['last_name']).to_s[0,1]}" unless ticket['assigned_to'].nil?
        
        say Hirb::Helpers::Table.render [{
          :id => ticket['identifier'], 
          :type => ticket['type'],
          :title => ticket['title'],
          :created_by => "#{ticket['created_by']['user']['first_name']} #{(ticket['created_by']['user']['last_name']).to_s[0,1]}",
          :due_date => due_date,
          :assigned_to => assigned_to,
          :priority => ticket['priority']
          }], 
          :fields => [:id, :type, :title, :created_by, :due_date, :assigned_to, :priority],
          :headers => { :created_by => "created by", :due_date => "due date", :assigned_to => "assigned to" }
      end
    end
  end
end