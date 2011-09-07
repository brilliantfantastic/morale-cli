require 'rubygems'
require 'thor'

module Morale
  class Command < Thor
    
    desc "test", "this is the shit"
    def test
      puts "Do some shit!"
    end
    
  end
end