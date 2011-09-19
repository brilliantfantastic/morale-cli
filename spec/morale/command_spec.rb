require "spec_helper"
require "morale/command"

describe Morale::Command do
  describe "#login" do
    it "should display instructions if credentials are not yet stored" do
      Morale::Account.subdomain = "blah"
      stub_request(:post, "http://blah.lvh.me:3000/api/v1/in").to_return(:body => { "api_key" => "blah!" }.to_json)
      output = process('someone@somewhere.com') { Morale::Command.start ["login"] }
      output[:stdout].should =~ /Sign in to Morale./
    end
    
    it "should ask for your email if credentials are not yet stored" do
      Morale::Account.subdomain = "blah"
      stub_request(:post, "http://blah.lvh.me:3000/api/v1/in").to_return(:body => { "api_key" => "blah!" }.to_json)
      output = process('someone@somewhere.com') { Morale::Command.start ["login"] }
      output[:stdout].should =~ /Email: /
    end
    
    it "should ask for your password if credentials are not yet stored" do
      Morale::Account.subdomain = "blah"
      stub_request(:post, "http://blah.lvh.me:3000/api/v1/in").to_return(:body => { "api_key" => "blah!" }.to_json)
      output = process('someone@somewhere.com') { Morale::Command.start ["login"] }
      output[:stdout].should =~ /Password: /
    end
    
    it "should store your api key once you have signed in if credentials are not yet stored" do
      Morale::Account.subdomain = "blah"
      stub_request(:post, "http://blah.lvh.me:3000/api/v1/in").to_return(:body => { "api_key" => "api_key" }.to_json)
      output = process('someone@somewhere.com') { Morale::Command.start ["login"] }
      File.read(Morale::Account.location).should =~ /blah/
      File.read(Morale::Account.location).should =~ /api_key/
    end
  end
  
  describe "#accounts" do
    it "should return all the group names for an account that a user has access to" do
      stub_request(:get, "http://lvh.me:3000/api/v1/accounts?email=someone@example.com").to_return(:body => 
        [{"account" => {"group_name" => "Shimmy Sham","site_address"=>"shimmy_sham","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","plan_id" => 1,"id" => 2}},
         {"account" => {"group_name" => "Pumpkin Tarts","site_address"=>"pumpkin_tarts","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","plan_id" => 1,"id" => 1}}].to_json)
         
      output = process() { Morale::Command.start(["accounts", "someone@example.com"]) }
      output[:stdout].should =~ /1. Pumpkin Tarts/
      output[:stdout].should =~ /2. Shimmy Sham/
    end
  end
  
  describe "#projects" do
    it "should return all the project names for an account" do
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/projects").to_return(:body => 
        [{"project" => {"name" => "Skunk Works","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","account_id" => 1,"id" => 1}},
         {"project" => {"name" => "Poop Shoot","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","account_id" => 1,"id" => 2}}].to_json)
         
      output = process() { Morale::Command.start(["projects"]) }
      output[:stdout].should =~ /1. Poop Shoot/
      output[:stdout].should =~ /2. Skunk Works/
    end
    
    it "should raise unauthorized if a 401 is retrieved" do
      stub_request(:post, "http://blah.lvh.me:3000/api/v1/in").to_return(:body => { "api_key" => "blah!" }.to_json)
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/projects").to_return(:status => 401)
         
      output = process() { Morale::Command.start(["projects"]) }
      output[:stdout].should =~ /Authentication failure/
    end
  end
end