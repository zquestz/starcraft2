require 'spec_helper'

describe Starcraft2::Profile::Career do
  let(:profile) { Starcraft2::Profile::Career.new(@options) }

  before do
    @options = {}
  end

  it 'should store the primary_race' do
    @options = {:primary_race => 'PROTOSS'}
    profile.primary_race.should == 'PROTOSS'
  end

  it 'should store the league' do
    @options = {:league => 'GAMMA'}
    profile.league.should == 'GAMMA'
  end

  it 'should store the terran_wins' do
    @options = {:terran_wins => 121}
    profile.terran_wins.should == 121
  end

  it 'should store the protoss_wins' do
    @options = {:protoss_wins => 123}
    profile.protoss_wins.should == 123
  end

  it 'should store the zerg_wins' do
    @options = {:zerg_wins => 82}
    profile.zerg_wins.should == 82
  end

  it 'should store the highest_1v1_rank' do
    @options = {:highest_1v1_rank => 'GOLD'}
    profile.highest_1v1_rank.should == 'GOLD'
  end

  it 'should store the highest_team_rank' do
    @options = {:highest_team_rank => 'MASTER'}
    profile.highest_team_rank.should =='MASTER'
  end

  it 'should store the season_total_games' do
    @options = {:season_total_games => 596}
    profile.season_total_games.should == 596
  end

  it 'should store the career_total_games' do
    @options = {:career_total_games => 1293}
    profile.career_total_games.should == 1293
  end
end
