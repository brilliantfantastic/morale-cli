require "spec_helper"
require "morale/command"

describe Morale::Command do
  describe "#accounts" do
    it "should return all the group names for an account that a user has access to" do
      stub_request(:get, "http://blah.lvh.me:3000/api/v1/accounts").to_return(:body => 
        [{"account" => {"group_name" => "Shimmy Sham","site_address"=>"shimmy_sham","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","plan_id" => 1,"id" => 2}},
         {"account" => {"group_name" => "Pumpkin Tarts","site_address"=>"pumpkin_tarts","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","plan_id" => 1,"id" => 1}}].to_json)
         
      output = capture(:stdout) { Morale::Command.start(["accounts", "someone@example.com"]) }
      output.should =~ /1. Pumpkin Tarts/
      output.should =~ /2. Shimmy Sham/
    end
  end
  
  describe "#projects" do
    it "should return all the project names for an account" do
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/projects").to_return(:body => 
        [{"project" => {"name" => "Skunk Works","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","account_id" => 1,"id" => 1}},
         {"project" => {"name" => "Poop Shoot","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","account_id" => 1,"id" => 2}}].to_json)
         
      output = capture(:stdout) { Morale::Command.start(["projects"]) }
      output.should =~ /1. Poop Shoot/
      output.should =~ /2. Skunk Works/
    end
    
    it "should raise unauthorized if a 401 is retrieved" do
      stub_request(:get, "http://blah:@blah.lvh.me:3000/api/v1/projects").to_return(:status => 401)
         
      output = capture(:stdout) { Morale::Command.start(["projects"]) }
      output.should =~ /Authentication failure/
    end
  end
end