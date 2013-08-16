require 'spec_helper'

describe Starcraft2::Profile::Stats do
  describe '.initialize' do
    let(:stats) { Starcraft2::Profile::Stats.new(@options) }

    before do
      @options = {'type' => 'foo', 'wins' => 5, 'games' => 40}
    end

    it 'should store attributes as underscored' do
      stats.type.should == 'foo'
      stats.wins.should == 5
      stats.games.should == 40
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      stats
    end
  end

  describe '#build' do
    let(:stats_array) { Starcraft2::Profile::Stats.build(@items) }

    before do
      @items = [
        {'type' => 'foo'},
        {'type' => 'bar'}
      ]
    end

    it 'should build multiple stats objects' do
      stats_array.class.should == Array
      stats_array.each do |s|
        s.class.should == Starcraft2::Profile::Stats
      end
    end

    it 'should build items using new' do
      @items.each do |i|
        Starcraft2::Profile::Stats.should_receive(:new).with(i)
      end

      stats_array
    end
  end
end