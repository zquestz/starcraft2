require 'spec_helper'

describe Starcraft2::Profile do
  let(:client) { Starcraft2::Client.new }
  let(:profile) { Starcraft2::Profile.new(@options) }

  describe '#build' do
    let(:profile) { Starcraft2::Profile.build(client, @profile_json) }

    before do
      VCR.use_cassette("profile_999000") do
        @profile_json = HTTParty.get('https://us.battle.net/api/sc2/profile/999000/1/DayNine/').body
      end
    end

    it 'should build a profile' do
      profile.class.should == Starcraft2::Profile
    end
  end

  describe '.initialize' do
    before do
      @options = {}
    end

    it 'should store the id' do
      @options = {:id => 12345}
      profile.id.should == 12345
    end

    it 'should store the realm' do
      @options = {:realm => 1}
      profile.realm.should == 1
    end

    it 'should store the display_name' do
      @options = {:display_name => 'steve'}
      profile.display_name.should == 'steve'
    end

    it 'should store the clan_name' do
      @options = {:clan_name => 'clan'}
      profile.clan_name.should == 'clan'
    end

    it 'should store the clan_tag' do
      @options = {:clan_tag => 'tag'}
      profile.clan_tag.should == 'tag'
    end

    it 'should store the profile_path' do
      @options = {:profile_path => '/profile/example'}
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
      @options = {
        :career => {
          :primary_race => 'TERRAN',
          :league => 'KAPPA',
          :terran_wins => 1,
          :protoss_wins => 268,
          :zerg_wins => 7,
          :highest1v1_rank => 'MASTER',
          :highest_team_rank => 'MASTER',
          :season_total_games => 399,
          :career_total_games => 1531
        }
      }
      profile.career.primary_race.should == 'TERRAN'
      profile.career.league.should == 'KAPPA'
      profile.career.terran_wins.should == 1
      profile.career.protoss_wins.should == 268
      profile.career.zerg_wins.should == 7
      profile.career.highest1v1_rank.should == 'MASTER'
      profile.career.highest_team_rank.should == 'MASTER'
      profile.career.season_total_games.should == 399
      profile.career.career_total_games.should == 1531
    end

    it 'should store the swarm_levels' do
      @options = {
        :swarm_levels => {
          :level => 45,
          :terran => {
            :level => 9,
            :total_level_XP => 150000,
            :current_level_XP => 8826
          },
          :zerg => {
            :level => 6,
            :total_level_XP => 150000,
            :current_level_XP => 1231
          },
          :protoss => {
            :level => 30,
            :total_level_XP => 150000,
            :current_level_XP => 8826
          }
        }
      }

      profile.swarm_levels.class.should == Starcraft2::Profile::SwarmLevels
      profile.swarm_levels.level.should == 45

      terran = profile.swarm_levels.terran
      terran.class.should == Starcraft2::Profile::SwarmRace
      terran.level.should == 9
      terran.total_level_xp.should == 150000
      terran.current_level_xp.should == 8826

      zerg = profile.swarm_levels.zerg
      zerg.class.should == Starcraft2::Profile::SwarmRace
      zerg.level.should == 6
      zerg.total_level_xp.should == 150000
      zerg.current_level_xp.should == 1231

      protoss = profile.swarm_levels.protoss
      protoss.class.should == Starcraft2::Profile::SwarmRace
      protoss.level.should == 30
      protoss.total_level_xp.should == 150000
      protoss.current_level_xp.should == 8826
    end

    it 'should store the campaign' do
      @options = {:campaign => {:wol => 'BRUTAL', :hots => 'BRUTAL'}}
      profile.campaign.wol.should == 'BRUTAL'
      profile.campaign.hots.should == 'BRUTAL'
    end

    it 'should store the season' do
      @options = {
        :season => {
          :season_id => 14,
          :total_games_this_season => 399,
          :stats => [
            {
              :type => '1v1',
              :wins => 254,
              :games => 357
            }, {
              :type => '2v2',
              :wins => 27,
              :games => 39
            }
          ]
        }}
    end

    it 'should store the rewards' do
      @options = {
        :rewards => {
          :selected => [18730036, 2009110693, 2359737029, 4189275055],
          :earned => [144654643, 171155159, 199895074, 234481452, 367294557, 531423509, 533048170, 637508413]
        }
      }
      profile.rewards.selected.should == [18730036, 2009110693, 2359737029, 4189275055]
      profile.rewards.earned.should == [144654643, 171155159, 199895074, 234481452, 367294557, 531423509, 533048170, 637508413]
    end

    it 'should store the achievements' do
      @options = {
        :achievements => {
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
          :achievements => [
            {
              :achievementId => 91475320766493,
              :completionDate => 1375779974
            }, {
              :achievementId => 91475035553809,
              :completionDate => 1371117026
            }
          ]
        }
      }
    end
  end

  describe '.matches' do
    let(:client) { Starcraft2::Client.new() }

    it 'should return a list of matches' do
      VCR.use_cassette("matches_999000") do
        matches = client.profile(:character_name => 'DayNine', :id => 999000, :realm => 1).matches
        matches.class.should == Array
        matches.first.class.should == Starcraft2::Profile::Match
        matches.first.map.should == 'HOTS Unit Tester Online'
        matches.first.type.should == 'CUSTOM'
        matches.first.decision.should == 'BAILER'
        matches.first.speed.should == 'FASTER'
        matches.first.date.should == 1376528216
      end
    end
  end
end
