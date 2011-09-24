require 'morale/account'
require 'morale/client'
require 'morale/command'
require 'morale/authorization'

module Morale::Commands
  class Account
    class << self
      include Morale::Platform
      
      def list(email="", change=false)
        accounts = Morale::Client.accounts(email) unless email.nil? || email.empty?

        begin
          accounts = Morale::Command.client.accounts if email.nil? || email.empty?

          if !accounts.nil?
            accounts.sort{|a,b| a['account']['group_name'] <=> b['account']['group_name']}.each_with_index do |record, i|
              say "#{i += 1}. #{record['account']['group_name']}"
            end
            
            if change
              say "Choose an account: "
              index = ask
              account = accounts[index.to_i - 1]
              
              if account.nil?
                say "Invalid account."
              end
              Morale::Account.subdomain = account['account']['site_address'] unless account.nil?
            end
          else
            say "There were no accounts found."
          end
        rescue Morale::Client::Unauthorized, Morale::Client::NotFound
          say "Authentication failure"
          Morale::Commands::Authorization.login
          retry if Morale::Authorization.retry_login? && !change
        end
      end
      
      def select(id)
        begin
          accounts = Morale::Command.client.accounts
          if !accounts.nil?
            account = accounts[id.to_i - 1]
            if account.nil?
              say "Invalid account."
            end
            Morale::Account.subdomain = account['account']['site_address'] unless account.nil?
          else
            say "There were no accounts found."
          end
        rescue Morale::Client::Unauthorized, Morale::Client::NotFound
          say "Authentication failure"
          Morale::Commands::Authorization.login
        end
      end
    end
  end
end