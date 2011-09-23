require 'morale/client'
require 'morale/command'
require 'morale/authorization'

module Morale::Commands
  class Account
    class << self
      include Morale::Platform
      
      def list(email="")
        accounts = Morale::Client.accounts(email) unless email.nil? || email.empty?

        begin
          accounts = Morale::Command.client.accounts if email.nil? || email.empty?

          if !accounts.nil?
            accounts.sort{|a,b| a['account']['group_name'] <=> b['account']['group_name']}.each_with_index do |record, i|
              say "#{i += 1}. #{record['account']['group_name']}"
            end
          else
            say "There were no accounts found."
          end
        rescue Morale::Client::Unauthorized, Morale::Client::NotFound
          say "Authentication failure"
          Morale::Commands::Authorization.login
          retry if Morale::Authorization.retry_login?
        end
      end
      
    end
  end
end