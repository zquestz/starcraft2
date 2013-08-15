require 'spec_helper'

describe Starcraft2::Profile::Match do
  describe '.initialize' do
    let(:match) { Starcraft2::Profile::Match.new(@options) }

    before do
      @options = {'map' => 'foo', 'type' => 'bar', 'decision' => 'wowzer', 'speed' => 'slow', 'date' => 37373837}
    end

    it 'should store attributes as underscored' do
      match.map.should == 'foo'
      match.type.should == 'bar'
      match.decision.should == 'wowzer'
      match.speed.should == 'slow'
      match.date.should == 37373837
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      match
    end
  end

  describe '#build' do
    let(:matches) { Starcraft2::Profile::Match.build(@items) }

    before do
      @items = {
        'matches' => [
          {'map' => 'uno'},
          {'map' => 'due'}
        ]
      }
    end

    it 'should build multiple matches' do
      matches.class.should == Array
      matches.each do |ai|
        ai.class.should == Starcraft2::Profile::Match
      end
    end

    it 'should build items using new' do
      @items['matches'].each do |i|
        Starcraft2::Profile::Match.should_receive(:new).with(i)
      end

      matches
    end
  end
end