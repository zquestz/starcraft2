require 'spec_helper'

describe StringUtils do
  describe "#underscore" do
    it "should underscore a string" do
      StringUtils.underscore("FooBar").should == "foo_bar"
    end
  end
end