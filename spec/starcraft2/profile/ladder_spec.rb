require 'spec_helper'

describe Starcraft2::Profile::Ladder do
  describe '.initialize' do
    let(:ladder) { Starcraft2::Profile::Ladder.new(@options) }

    it 'should store attributes as underscored' do
      @options = {
        'ladderName' => 'Shuttle Tango',
        'ladderId' => 153300,
        'division' => 34,
        'rank' => 28,
        'league' => 'PLATINUM',
        'matchMakingQueue' => 'HOTS_TWOS',
        'wins' => 7,
        'losses' => 1,
        'showcase' => true
      }

      ladder.ladder_name.should == 'Shuttle Tango'
      ladder.ladder_id.should == 153300
      ladder.division.should == 34
      ladder.rank.should == 28
      ladder.league.should == 'PLATINUM'
      ladder.match_making_queue.should == 'HOTS_TWOS'
      ladder.wins.should == 7
      ladder.losses.should == 1
      ladder.showcase.should == true
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      ladder
    end
  end

  describe '#build' do
    let(:ladders) { Starcraft2::Profile::Ladder.build(@items) }

    before do
      @items = [
        {'ladderName' => 'Shuttle Tango'},
        {'ladderName' => 'Other'}
      ]
    end

    it 'should build multiple ladders' do
      ladders.class.should == Array
      ladders.each do |l|
        l.class.should == Starcraft2::Profile::Ladder
      end
    end

    it 'should build items using new' do
      @items.each do |i|
        Starcraft2::Profile::Ladder.should_receive(:new).with(i)
      end

      ladders
    end
  end
end