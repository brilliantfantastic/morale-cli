require 'spec_helper'
require 'morale/account'

describe Morale::Account do
  describe "#subdomain" do
    it "should store the subdomain in the credentials file" do
      Morale::Account.subdomain = "blah"
      File.read(Morale::Account.location).should =~ /blah/
    end
  end
end