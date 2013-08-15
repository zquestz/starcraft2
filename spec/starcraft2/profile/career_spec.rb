require 'spec_helper'

describe Starcraft2::Profile::Career do
  let(:career) { Starcraft2::Profile::Career.new(@options) }

  before do
    @options = {
      'primaryRace' => 'PROTOSS',
      'league' => 'GAMMA',
      'terranWins' => 121,
      'protossWins' => 123,
      'zergWins' => 82,
      'highest1v1Rank' => 'GOLD',
      'highestTeamRank' => 'MASTER',
      'seasonTotalGames' => 596,
      'careerTotalGames' => 1293
    }
  end

  it 'should store attributes as underscored' do
    career.primary_race.should == 'PROTOSS'
    career.league.should == 'GAMMA'
    career.terran_wins.should == 121
    career.protoss_wins.should == 123
    career.zerg_wins.should == 82
    career.highest1v1_rank.should == 'GOLD'
    career.highest_team_rank.should =='MASTER'
    career.season_total_games.should == 596
    career.career_total_games.should == 1293
  end

  it 'should use Stracraft2::Utils.load to populate the model' do
    Starcraft2::Utils.should_receive(:load).with(anything, @options)

    career
  end
end
