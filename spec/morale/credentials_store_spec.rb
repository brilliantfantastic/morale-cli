require 'spec_helper'
require 'morale/credentials_store'

describe Morale::CredentialsStore do
  
  class Dummy; end
  before (:each) do
    @dummy = Dummy.new
    @dummy.extend(Morale::CredentialsStore)
  end
  
  describe "#location" do
    it "should return the correct location of the credentials file" do
      @dummy.location.should == "#{ENV['HOME']}/.morale/credentials"
    end
  end
end