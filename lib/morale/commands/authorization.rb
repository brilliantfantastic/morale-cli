require 'morale/authorization'

module Morale::Commands
  class Authorization
    class << self
      
      def login
        Morale::Authorization.login
      end
      
    end
  end
end