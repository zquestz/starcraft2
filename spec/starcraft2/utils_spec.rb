require 'spec_helper'

describe Starcraft2::Utils do
  describe '#underscore' do
    it 'should underscore a string' do
      Starcraft2::Utils.underscore('FooBar').should == 'foo_bar'
    end
  end

  describe '#load' do
    it 'should load attributes in a class' do
      icon = Starcraft2::Icon.new()
      icon.x.should == nil
      icon.y.should == nil
      Starcraft2::Utils.load(icon, {:x => 2, :y => 3})
      icon.x.should == 2
      icon.y.should == 3
    end

    it 'should allow a key to initialize another class' do
      member = Starcraft2::Member.new()
      Starcraft2::Utils.load(member, {:points => 10, :character => {:display_name => 'steve'}}, {:character => Starcraft2::Character})
      member.points.should == 10
      member.character.class.should == Starcraft2::Character
      member.character.display_name.should == 'steve'
    end
  end
end