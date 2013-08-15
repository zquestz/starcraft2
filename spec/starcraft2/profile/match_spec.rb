require 'spec_helper'

describe Starcraft2::Profile::Match do
  let(:match) {Starcraft2::Profile::Match.new(@options)}

  before do
    @options = {}
  end

  it 'should set the map' do
    @options = {:map => 'foo'}
    match.map.should == 'foo'
  end

  it 'should set the type' do
    @options = {:type => 'bar'}
    match.type.should == 'bar'
  end

  it 'should set the decision' do
    @options = {:decision => 'wowzer'}
    match.decision.should == 'wowzer'
  end

  it 'should set the speed' do
    @options = {:speed => 'slow'}
    match.speed.should == 'slow'
  end

  it 'should set the date' do
    @options = {:date => 37373837}
    match.date.should == 37373837
  end
end