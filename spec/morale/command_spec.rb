require "spec_helper"
require "morale/command"

describe Morale::Command do
  describe "#projects" do
    it "should return all the project names for an account" do
      stub_request(:get, "http://blah.teammorale.com/api/v1/projects").to_return(:body => 
        [{"project" => {"name" => "Skunk Works","created_at" => "2011-07-31T21:40:24Z","updated_at" => "2011-07-31T21:40:24Z","account_id" => 1,"id" => 1}},
         {"project" => {"name" => "Poop Shoot","created_at" => "2011-07-31T21:28:53Z","updated_at" => "2011-07-31T21:28:53Z","account_id" => 1,"id" => 2}}].to_json)
         
      output = capture(:stdout) { Morale::Command.start(["projects"]) }
      output.should =~ /1. Poop Shoot/
      output.should =~ /2. Skunk Works/
    end
  end
end