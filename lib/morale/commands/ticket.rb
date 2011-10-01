require 'morale/client'
require 'morale/command'
require 'morale/authorization'
require 'hirb'

module Morale::Commands
  class Ticket
    class << self
      include Morale::Platform
      
      def command(command)
        print Morale::Command.client.ticket(Morale::Account.project, command)
      end
      
      def list
        print Morale::Command.client.tickets({ :project_id => Morale::Account.project })
      end
      
      private
      
      def print(tickets)
        say Hirb::Helpers::Table.render fetch(tickets), 
          :fields => [:id, :type, :title, :created_by, :due_date, :assigned_to, :priority],
          :headers => { :created_by => "created by", :due_date => "due date", :assigned_to => "assigned to" }
      end
      
      def fetch(tickets)
        tickets = tickets.kind_of?(Array) ? tickets : Array.new(1, tickets)
        data = []
        tickets.each { |t| 
          ticket = t['task'] unless t['task'].nil?
          ticket = t['bug'] unless t['bug'].nil?
          ticket = t if ticket.nil?
          
          due_date = ticket['due_date']
          unless due_date.nil?
            due_date = Date.parse(due_date) unless due_date.kind_of?(Time)
            due_date = due_date.strftime("%b. %d")
          end
          assigned_to = "#{ticket['assigned_to']['user']['first_name']} #{(ticket['assigned_to']['user']['last_name']).to_s[0,1]}." unless ticket['assigned_to'].nil?
          
          data << {
            :id => ticket['identifier'], 
            :type => ticket['type'],
            :title => ticket['title'],
            :created_by => "#{ticket['created_by']['user']['first_name']} #{(ticket['created_by']['user']['last_name']).to_s[0,1]}.",
            :due_date => due_date,
            :assigned_to => assigned_to,
            :priority => ticket['priority']
          } 
        }
        data
      end
    end
  end
end