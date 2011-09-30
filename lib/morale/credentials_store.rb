require 'morale/storage'
require 'morale/platform'

module Morale
  module CredentialsStore
    include Morale::Storage
    include Morale::Platform
    
    attr_accessor :credentials
    
    def location
      ENV['CREDENTIALS_LOCATION'] || default_location
    end
    
    def location=(value)
      ENV['CREDENTIALS_LOCATION'] = value
    end
    
    def default_location
      "#{home_directory}/.morale/credentials"
    end
    
    def read_credentials
      creds = self.read
      creds.split("\n") if creds
    end
    
    def write_credentials
      self.write self.credentials
    end
    
    def delete_credentials
      self.delete
      @credentials = nil
    end
  end
end