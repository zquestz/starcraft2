require 'spec_helper'

describe Starcraft2::Profile do
  let(:profile) { Starcraft2::Profile.new(@options) }

  before do
    @options = {}
  end

  describe '.initialize' do

    it 'should store the id' do
      @options = { :id => 12345 }
      profile.id.should == 12345
    end

    it 'should store the realm' do
      @options = { :realm => 1}
      profile.realm.should == 1
    end

    it 'should store the display_name' do
      @options = { :display_name => 'steve' }
      profile.display_name.should == 'steve'
    end

    it 'should store the clan_name' do
      @options = { :clan_name => 'clan' }
      profile.clan_name.should == 'clan'
    end

    it 'should store the clan_tag' do
      @options = { :clan_tag => 'tag' }
      profile.clan_tag.should == 'tag'
    end

    it 'should store the profile_path' do
      @options = { :profile_path => '/profile/example' }
      profile.profile_path.should == '/profile/example'
    end

    it 'should store the portrait' do
      @options = {:portrait => {'x' => 1, 'y' => 2, 'w' => 3, 'h' => 4, 'offset' => 0, 'url' => 'https://example.com'}}
      profile.portrait.x.should == 1
      profile.portrait.y.should == 2
      profile.portrait.w.should == 3
      profile.portrait.h.should == 4
      profile.portrait.offset.should == 0
      profile.portrait.url.should == 'https://example.com'
    end


    it 'should store the career' do
      @options = { :career =>  {:primary_race => 'TERRAN', :league => 'KAPPA',
      :terran_wins => 1, :protoss_wins => 268, :zerg_wins => 7,
      :highest_1v1_rank => 'MASTER', :highest_team_rank => 'MASTER',
      :season_total_games => 399, :career_total_games => 1531 } }
    end

    it 'should store the swarm_levels' do
      @options = { :swarm_levels => {
      :level => 45,
      :terran => {
        :level => 9,
        :total_level_XP   => 150000,
        :current_level_XP => 8826
      },
      :zerg => {
        :level => 6,
        :total_level_XP   => 150000,
        :current_level_XP => 1231
      },
      :protoss => {
        :level => 30,
        :total_level_XP   => 150000,
        :current_level_XP => 8826
      }}}
    end

    it 'should store the campaign' do
      @options = { :campaign => { :wol => 'BRUTAL', :hots => 'BRUTAL'}}
    end

    it 'should store the season' do
      @options = { :season => { :season_id => 14, :total_games_this_season => 399, :stats => [{
          :type => '1v1',
          :wins => 254,
          :games => 357
        }, {
          :type => '2v2',
          :wins => 27,
          :games => 39
        }]
      }}
    end

    it 'should store the rewards' do
      @options = { :rewards => {
        :selected => [18730036, 2009110693, 2359737029, 4189275055],
        :earned => [144654643, 171155159, 199895074, 234481452, 367294557, 531423509, 533048170, 637508413, 693439517, 810340504, 822755320, 868991824, 960411262, 964469219, 983487403, 1034610896, 1060652497, 1101809667, 1177038943, 1271513287, 1391382166, 1443233935, 1453233559, 1467565626, 1516476230, 1542695810, 1563607663, 1605367309, 1686196380, 1716314872, 1750262021, 1756072743, 1807193192, 1837558682, 1916636256, 1919498533, 1950195664, 2069737544, 2113477352, 2184379176, 2212045446, 2222924803, 2288979736, 2290710696, 2410972062, 2419802213, 2486919067, 2584611494, 2646575556, 2799540787, 2834383599, 2976815359, 3032291021, 3045219362, 3247325755, 3281768270, 3313345670, 3319454886, 3369138675, 3399536420, 3492698187, 3566090531, 3625001715, 3630735430, 3638208774, 3652426167, 3661724208, 3688882959, 3717856077, 3846834130, 3968752759, 3977184535, 4051538931, 4067140795, 4130543639, 4179975174, 4189275055, 4196367769, 4213726124, 4229064357, 4235385817, 4241103608]
      }}
    end

    it 'should store the achievements' do
        @options = { :achievements => {
        :points => {
          :totalPoints => 3375,
          :categoryPoints => {
            '4325382' => 0,
            '4325380' => 390,
            '4325408' => 90,
            '4325379' => 915,
            '4325410' => 1380,
            '4325377' => 600
          }
        },
        :achievements => [{
          :achievementId => 91475320766493,
          :completionDate => 1375779974
        }, {
          :achievementId => 91475035553809,
          :completionDate => 1371117026
        }]
      }
    }
    end
  end
end
