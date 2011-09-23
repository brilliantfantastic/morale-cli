require "spec_helper"
require "json"
require "morale/client"

describe Morale::Client do
  describe "#authorize" do
    it "authorizes a user with a valid email address and password" do
      api_key = "blah"
      stub_request(:post, "http://blah.lvh.me:3000/api/v1/in").to_return(:body => { "api_key" => "#{api_key}" }.to_json)
      Morale::Client.authorize(nil, nil, 'blah').api_key.should == api_key
    end
  end
  
  describe "#accounts" do
    it "displays all the accounts for a specific user based on their email" do
      stub_request(:get, "http://lvh.me:3000/api/v1/accounts?email=someone@example.com").to_return(:body => 
        [{"account" => {"group_name" => "Shimmy Sham","site_address"=>"shimmy_sham","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","plan_id" => 1,"id" => 2}},
         {"account" => {"group_name" => "Pumpkin Tarts","site_address"=>"pumpkin_tarts","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","plan_id" => 1,"id" => 1}}].to_json)
         
      accounts = Morale::Client.accounts('someone@example.com')
      accounts.count.should == 2
    end
    
    it "displays all the accounts for a specific user based on their api_key" do
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/accounts?api_key=").to_return(:body => 
        [{"account" => {"group_name" => "Shimmy Sham","site_address"=>"shimmy_sham","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","plan_id" => 1,"id" => 2}},
         {"account" => {"group_name" => "Pumpkin Tarts","site_address"=>"pumpkin_tarts","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","plan_id" => 1,"id" => 1}}].to_json)
      
      client = Morale::Client.new('blah')   
      client.accounts.count.should == 2
      client.accounts[0]["account"]["group_name"].should == "Shimmy Sham"
    end
  end
  
  describe "#projects" do
    it "displays all the projects for a specific account" do
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/projects").to_return(:body => 
        [{"project" => {"name" => "Skunk Works","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","account_id" => 1,"id" => 1}},
         {"project" => {"name" => "Poop Shoot","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","account_id" => 1,"id" => 2}}].to_json)
      client = Morale::Client.new('blah')
      client.projects.count.should == 2
      client.projects[0]["project"]["name"].should == "Skunk Works"
      client.projects[1]["project"]["id"].should == 2
    end
    
    it "should raise unauthorized if a 401 is received" do
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/projects").to_return(:status => 401)
      client = Morale::Client.new('blah')
      lambda { client.projects.count }.should raise_error(Morale::Client::Unauthorized)
    end
  end
end