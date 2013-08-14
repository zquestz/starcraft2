require 'spec_helper'

describe Starcraft2::StringUtils do
  describe '#underscore' do
    it 'should underscore a string' do
      Starcraft2::StringUtils.underscore('FooBar').should == 'foo_bar'
    end
  end
end