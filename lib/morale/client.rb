require 'httparty'
require "json"

module Morale
  class Client
    class Unauthorized  < RuntimeError; end
    
    include HTTParty
    format :json
    
    API_VERSION = 'v1'
    
    attr_accessor :api_key
    attr_reader   :subdomain
    
    def self.authorize(user, password, subdomain)
      client = new(subdomain)
      client.api_key = client.class.post('/in', { :email => user, :password => password })["api_key"]
      return client
    end
    
    def initialize(subdomain, api_key = "")
      @api_key = api_key
      @subdomain = subdomain
      #TODO: Save the domain in a config file
      self.class.default_options[:base_uri] = HTTParty.normalize_base_uri("#{subdomain}.lvh.me:3000/api/#{API_VERSION}")
    end
    
    def accounts(user)
      unauthorize
      response = self.class.get('/accounts', { :email => user })
      raise Unauthorized if response.code == 401
      response
    end
    
    def projects
      authorize
      response = self.class.get('/projects')
      raise Unauthorized if response.code == 401
      response
    end
    
    def default_project=(project)
    end
    
    def default_project
    end
    
    def tickets(options={})
    end
    
    private
    
    def authorize
      self.class.basic_auth @subdomain, @api_key
    end
    
    def unauthorize
      self.class.basic_auth nil, nil
    end
    
  end
end