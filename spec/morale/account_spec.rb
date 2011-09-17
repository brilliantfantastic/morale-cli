require 'spec_helper'
require 'morale/account'

describe Morale::Account do
  describe "#subdomain" do
    it "should store the subdomain in a configuration file" do
      Morale::Account.subdomain = "blah"
      #TODO: Check the file to see if the subdomain is stored
    end
  end
end