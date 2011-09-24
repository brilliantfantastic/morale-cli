require 'morale/flow'
require 'morale/credentials_store'

module Morale
  class Account
    include Morale::Platform
    
    class << self
      include Morale::CredentialsStore
      include Morale::Flow
      
      def subdomain
        if @subdomain.nil?
          get_credentials
          @subdomain = @credentials[0]
        end
        @subdomain
      end
      
      def subdomain=(value)
        @subdomain = value
        @credentials ||= []
        @credentials[0] = value
        write_credentials
      end
      
      def api_key
        get_credentials
        @credentials[1]
      end
      
      def retry_login?
        @login_attempts ||= 0
        @login_attempts += 1
        @login_attempts < 3
      end
      
      def get_credentials
        return if @credentials
        unless @credentials = read_credentials
          ask_for_and_save_credentials
        end
        @credentials
      end
      
      private

      def ask_for_and_save_credentials
        @credentials = ask_for_credentials
        write_credentials
      end

      def ask_for_credentials
        user ||= nil
        
        begin
          user = ask_for_subdomain if @subdomain.nil?
        rescue Morale::Client::NotFound
          say "Email is not registered."
          return
        end
        
        say "Sign in to Morale."

        if user.nil?
          say "Email: "
          user = ask
        end

        say "Password: "
        password = running_on_windows? ? ask_for_secret_on_windows : ask_for_secret
        api_key = Morale::Client.authorize(user, password, @subdomain).api_key

        say "Invalid email/password combination or API key was not generated." if api_key.nil?

        [@subdomain, api_key]
      end
      
      def ask_for_subdomain
        say "No account specified for Morale."
        
        say "Email: "
        user = ask

        accounts = Morale::Client.accounts user
        account = nil
        
        #TODO: This is the same as the account.list --change
        retryable(:indefinate => true) do
          accounts.sort{|a,b| a['account']['group_name'] <=> b['account']['group_name']}.each_with_index do |record, i|
            say "#{i += 1}. #{record['account']['group_name']}"
          end

          say "Choose an account: "
          index = ask
          account = accounts[index.to_i - 1]
          
          if account.nil?
            say "Invalid account."
            raise Exception
          end
        end

        @subdomain = account['account']['site_address'] unless account.nil?
        user
      end
    end
  end
end