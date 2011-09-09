require 'httparty'
require "json"

module Morale
  class Client
    include HTTParty
    format :json
    
    API_VERSION = 'v1'
    
    attr_accessor :api_key
    
    def self.authorize(user, password, subdomain)
      client = new(subdomain)
      client.api_key = client.class.post('/in', { :email => user, :password => password })["api_key"]
      return client
    end
    
    def initialize(subdomain, api_key = "")
      @api_key = api_key
      self.class.default_options[:base_uri] = HTTParty.normalize_base_uri("#{subdomain}.teammorale.com/api/#{API_VERSION}")
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