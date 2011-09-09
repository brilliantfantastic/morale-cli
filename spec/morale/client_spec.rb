require "spec_helper"
require "json"
require "morale/client"

describe Morale::Client do
  describe "#authorize" do
    it "authorizes a user with a valid email address and password" do
      api_key = "blah"
      stub_request(:post, "http://blah.teammorale.com/api/v1/in").to_return(:body => { "api_key" => "#{api_key}" }.to_json)
      Morale::Client.authorize(nil, nil, 'blah').api_key.should == api_key
    end
  end
  
  describe "#projects" do
    it "grabs all the projects for a specific account" do
      stub_request(:get, "http://blah.teammorale.com/api/v1/projects").to_return(:body => 
        [{"project" => {"name" => "Skunk Works","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","account_id" => 1,"id" => 1}},
         {"project" => {"name" => "Poop Shoot","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","account_id" => 1,"id" => 2}}].to_json)
      client = Morale::Client.new('blah')
      client.projects.count.should == 2
      client.projects[0]["project"]["name"].should == "Skunk Works"
      client.projects[1]["project"]["id"].should == 2
    end
  end
end