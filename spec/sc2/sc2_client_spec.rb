require "spec_helper"

describe SC2::Client do
  let(:client) { SC2::Client.new(@options)}

  it "should store the locale" do
    @options = { :locale => "en_US" }
    client.locale.should == "en_US"
  end
end