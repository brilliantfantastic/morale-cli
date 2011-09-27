require 'morale/client'
require 'morale/command'
require 'morale/authorization'

module Morale::Commands
  class Ticket
    class << self
      include Morale::Platform
      
      def command(command)
        Morale::Command.client.ticket Morale::Account.project, command
      end
    end
  end
end