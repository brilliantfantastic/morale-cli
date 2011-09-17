require 'morale/credentials_store'

module Morale
  class Account
    class << self
      
      include Morale::CredentialsStore
      
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
        #user = ask_for_subdomain if @subdomain.nil?
        
        puts "Sign in to Morale."

        if user.nil?
          print "Email: "
          user = ask
        end

        print "Password: "
        password = running_on_windows? ? ask_for_secret_on_windows : ask_for_secret
        api_key = Morale::Client.authorize(user, password, @subdomain).api_key

        [@subdomain, api_key]
      end
      
      def ask_for_subdomain
        puts "No account specified for Morale."
        
        print "Email: "
        user = ask
        
        accounts = Morale::Client.accounts user
        print "Choose an account: "
        index = ask
        user
      end
    end
  end
end