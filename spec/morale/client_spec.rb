require "spec_helper"
require "json"
require "morale/client"

describe Morale::Client do
  describe "#authorize" do
    it "authorizes a user with a valid email address and password" do
      result = { "api_key" => "blah" }
      stub_request(:post, "http://blah.teammorale.com/api/v1/in").to_return(:body => result.to_json)
      Morale::Client.authorize(nil, nil, 'blah').should == result
    end
  end
end