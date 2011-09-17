require 'spec_helper'
require 'morale/credentials_store'

describe Morale::CredentialsStore do
  
  class Dummy; end
  before (:each) do
    @dummy = Dummy.new
    @dummy.extend(Morale::CredentialsStore)
  end
  
  after (:each) do
    @dummy.delete_credentials
  end
  
  describe "#location" do
    it "should return the correct location of the credentials file" do
      @dummy.location.should == "#{ENV['HOME']}/.morale/credentials"
    end
  end
  
  describe "#delete_credentials" do
    it "should clear the credentials field" do
      @dummy.credentials = "Blah!"
      @dummy.delete_credentials
      @dummy.credentials.should be_nil
    end
    
    it "should delete the credentials file" do
      FileUtils.mkdir_p(File.dirname(@dummy.location))
      f = File.open(@dummy.location, 'w')
      f.puts "Blah!"
      
      @dummy.delete_credentials
      File.exists?(@dummy.location).should be_false
    end
  end
  
  describe "#write_credentials" do
    it "should write data to the location of the credentials file" do
      @dummy.credentials = "Blah!"
      @dummy.write_credentials
      File.read(@dummy.location).should =~ /Blah!/
    end
  end
end