require 'morale/credentials_store'

module Morale
  class Account
    class << self
      
      include Morale::CredentialsStore
      
      def subdomain
        @subdomain
      end
      
      def subdomain=(value)
        @subdomain = value
        #TODO: Store in file
      end
    end
  end
end