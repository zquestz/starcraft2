require "spec_helper"

describe SC2::Client do
  let(:client) { SC2::Client.new(@options)}

  before do
    @options = {}
  end

  it "should store the locale" do
    @options = { :locale => "en_US" }
    client.locale.should == "en_US"
  end

  it "should return an array of achievements" do
    client.achievements.class.should == Array
  end

  it "should return items of type SC2::Achievement" do
    client.achievements.first.class.should == SC2::Achievement
  end
end