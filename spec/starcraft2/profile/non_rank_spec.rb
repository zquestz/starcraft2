require 'spec_helper'

describe Starcraft2::Profile::NonRank do
  describe '.initialize' do
    let(:non_rank) { Starcraft2::Profile::NonRank.new(@options) }

    before do
      @options = {'mmq' => 'foo', 'gamesPlayed' => 10}
    end

    it 'should store attributes as underscored' do
      non_rank.mmq.should == 'foo'
      non_rank.games_played.should == 10
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      non_rank
    end
  end

  describe '#build' do
    let(:non_ranks) { Starcraft2::Profile::NonRank.build(@items) }

    before do
      @items = [
        {'mmq' => 'uno'},
        {'mmq' => 'due'}
      ]
    end

    it 'should build multiple non_rank objects' do
      non_ranks.class.should == Array
      non_ranks.each do |ai|
        ai.class.should == Starcraft2::Profile::NonRank
      end
    end

    it 'should build items using new' do
      @items.each do |i|
        Starcraft2::Profile::NonRank.should_receive(:new).with(i)
      end

      non_ranks
    end
  end
end