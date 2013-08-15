require 'spec_helper'

describe Starcraft2::Profile::Season do
  let(:season) { Starcraft2::Profile::Season.new(@options) }

  before do
    @options = {}
  end

  it 'should store the season_id' do
    @options = {:season_id => 11}
    season.season_id.should == 11
  end

  it 'should store the total_games_this_season' do
    @options = {:total_games_this_season => 252}
    season.total_games_this_season.should == 252
  end

  it 'should store the stats' do
    @options = {:stats => [{ :type => '1v1', :wins => 129, :games => 102 }, { :type => '2v2', :wins => 21, :games => 9}]}
    season.stats.class.should == Array
    season.stats.first.class.should == Starcraft2::Profile::Stats
    season.stats.first.type.should == '1v1'
    season.stats.first.wins.should == 129
    season.stats.first.games.should == 102
    season.stats.last.type.should == '2v2'
    season.stats.last.wins.should == 21
    season.stats.last.games.should == 9
  end
end
