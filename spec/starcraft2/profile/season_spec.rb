require 'spec_helper'

describe Starcraft2::Profile::Season do
  describe '.initialize' do
    let(:season) { Starcraft2::Profile::Season.new(@options) }

    before do
      @options = {
        'seasonId' => 11,
        'totalGamesThisSeason' => 252,
        'stats' => [{'type' => '1v1', 'wins' => 129, 'games' => 102}, {'type' => '2v2', 'wins' => 21, 'games' => 9}]
      }
    end

    it 'should store attributes as underscored' do
      season.season_id.should == 11
      season.total_games_this_season.should == 252

      season.stats.class.should == Array
      season.stats.each do |s|
        s.class.should == Starcraft2::Profile::Stats
      end

      s1 = season.stats.first
      s1.type.should == '1v1'
      s1.wins.should == 129
      s1.games.should == 102

      s2 = season.stats.last
      s2.type.should == '2v2'
      s2.wins.should == 21
      s2.games.should == 9
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options, {}, {:stats => Starcraft2::Profile::Stats})

      season
    end
  end
end