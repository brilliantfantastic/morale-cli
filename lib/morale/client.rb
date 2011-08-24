require 'httparty'
require "json"

module Morale
  class Client
    include HTTParty
    format :json
    
    API_VERSION = 'v1'
    
    attr_accessor :user, :password, :api_key
    
    def self.authorize(user, password, subdomain)
      client = new(user, password, subdomain)
      client.api_key = client.class.post('/in', { :email => client.user, :password => client.password })["api_key"]
      return client
    end
    
    def initialize(user, password, subdomain)
      @user = user
      @password = password
      @subdomain = subdomain
      self.class.default_options[:base_uri] = HTTParty.normalize_base_uri("#{@subdomain}.teammorale.com/api/#{API_VERSION}")
    end
    
    def projects
      self.class.get('/projects')
    end
    
    def default_project=(project)
    end
    
    def default_project
    end
    
    def tickets(options={})
    end
    
  end
end