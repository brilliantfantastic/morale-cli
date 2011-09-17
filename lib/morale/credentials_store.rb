require 'morale/platform'

module Morale
  module CredentialsStore
    include Morale::Platform
    
    def location
      "#{home_directory}/.morale/credentials"
    end
  end
end