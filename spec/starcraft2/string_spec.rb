require 'spec_helper'

describe String do
  it "should provide an underscore method" do
    "FooBar".underscore.should == "foo_bar"
  end
end