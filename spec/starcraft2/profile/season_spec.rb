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
    season.stats.first.should == Starcraft2::Profile::Stats
  end
end
