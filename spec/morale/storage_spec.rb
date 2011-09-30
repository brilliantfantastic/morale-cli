require 'spec_helper'
require 'morale/storage'

describe Morale::Storage do
  
  class Dummy; end
  before (:each) do
    @dummy = Dummy.new
    @dummy.extend(Morale::Storage)
    @dummy.location = "tmp/morale/store"
  end
  
  after (:each) do
    @dummy.delete
  end
  
  describe "#delete" do
    it "should delete the file" do
      FileUtils.mkdir_p(File.dirname(@dummy.location))
      f = File.open(@dummy.location, 'w')
      f.puts "Blah!"
      
      @dummy.delete
      File.exists?(@dummy.location).should be_false
    end
  end
  
  describe "#write" do
    it "should write data to the location of the file" do
      @dummy.write "Blah!"
      File.read(@dummy.location).should =~ /Blah!/
    end
  end
  
  describe "#read" do
    it "should read data from the location of the file" do
      FileUtils.mkdir_p(File.dirname(@dummy.location))
      f = File.open(@dummy.location, 'w')
      f.puts "Blah!"
      f.close
      @dummy.read.should =~ /Blah!/
    end
  end
end