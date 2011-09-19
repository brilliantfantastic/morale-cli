require 'morale/account'

module Morale
  class Authorization
    class << self
      def client
        Morale::Client.new(Morale::Account.subdomain, Morale::Account.api_key)
      end
      
      def login
        Morale::Account.delete_credentials
        Morale::Account.get_credentials
      end
      
      def retry_login?
        Morale::Account.retry_login?
      end
    end
  end
end