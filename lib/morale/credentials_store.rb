require 'morale/platform'

module Morale
  module CredentialsStore
    include Morale::Platform
    
    attr_accessor :credentials
    
    def location
      ENV['CREDENTIALS_LOCATION'] || default_location
    end
    
    def default_location
      "#{home_directory}/.morale/credentials"
    end
    
    def read_credentials
      File.exists?(location) and File.read(location).split("\n")
    end
    
    def write_credentials
      FileUtils.mkdir_p(File.dirname(location))
      f = File.open(location, 'w')
      f.puts self.credentials
      f.close
      set_credentials_permissions
    end
    
    def delete_credentials
      FileUtils.rm_f(location)
      @credentials = nil
    end
    
    private
    
    def set_credentials_permissions
      FileUtils.chmod 0700, File.dirname(location)
      FileUtils.chmod 0600, location
    end
  end
end