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
        @credentials = [] if @credentials.nil?
        @credentials[0] = value
        write_credentials
      end
      
      def api_key
        get_credentials
        @credentials[1]
      end
      
      def get_credentials
        return if @credentials
        unless @credentials = read_credentials
          ask_for_and_save_credentials
        end
        @credentials
      end
      
      def retry_login?
        @login_attempts ||= 0
        @login_attempts += 1
        @login_attempts < 3
      end
      
      private

      def ask_for_and_save_credentials
        @credentials = ask_for_credentials
        write_credentials
      end

      def ask_for_credentials
        puts "Sign in to Morale."

        print "Email: "
        user = ask

        print "Password: "
        password = running_on_windows? ? ask_for_secret_on_windows : ask_for_secret
        api_key = Morale::Client.authorize(user, password, @subdomain).api_key

        [@subdomain, api_key]
      end
    end
  end
end