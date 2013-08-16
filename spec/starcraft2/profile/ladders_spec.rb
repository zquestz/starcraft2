require 'spec_helper'

describe Starcraft2::Profile::Ladders do
  let(:ladder) { Starcraft2::Profile::Ladders.new(@options) }

  describe '.initialize' do
    before do
      @options = {}
    end

    it 'should store the current_season attributes as underscored' do
      @options = {
        'currentSeason' => [
          {
            'ladder' => [
              {
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
            ],
            'characters' => [
              {
                'id' => 999000,
                'realm' => 1,
                'displayName' => 'DayNine',
                'clanName' => 'Team 9',
                'clanTag' => 'Nine',
                'profilePath' => '/profile/999000/1/DayNine/'
              }, {
                'id' => 1283116,
                'realm' => 1,
                'displayName' => 'megumixbear',
                'clanName' => '',
                'clanTag' => '',
                'profilePath' => '/profile/1283116/1/megumixbear/'
              }
            ],
            'nonRanked' => []
          }, {
            'ladder' => [
              {
                'ladderName' => 'Torrasque Upsilon',
                'ladderId' => 154764,
                'division' => 59,
                'rank' => 90,
                'league' => 'PLATINUM',
                'matchMakingQueue' => 'HOTS_TWOS',
                'wins' => 4,
                'losses' => 1,
                'showcase' => true
              }
            ],
            'characters' => [
              {
                'id' => 999000,
                'realm' => 1,
                'displayName' => 'DayNine',
                'clanName' => 'Team 9',
                'clanTag' => 'Nine',
                'profilePath' => '/profile/999000/1/DayNine/'
              }, {
                'id' => 788150,
                'realm' => 1,
                'displayName' => 'JPMcD',
                'clanName' => 'itme',
                'clanTag' => 'itme',
                'profilePath' => '/profile/788150/1/JPMcD/'
              }
            ],
            'nonRanked' => []
          }
        ]
      }
      ladder.current_season.class.should == Array
      ladder.current_season.each do |cs|
        cs.class.should == Starcraft2::Profile::DetailedSeason
      end

      detailed_season = ladder.current_season.first
      detailed_season.ladder.class.should == Array
      detailed_season.ladder.first.class.should == Starcraft2::Profile::Ladder

      detailed_season.ladder.first.ladder_name.should == 'Shuttle Tango'
      detailed_season.ladder.first.ladder_id.should == 153300
      detailed_season.ladder.first.division.should == 34
      detailed_season.ladder.first.rank.should == 28
      detailed_season.ladder.first.league.should == 'PLATINUM'
      detailed_season.ladder.first.match_making_queue.should == 'HOTS_TWOS'
      detailed_season.ladder.first.wins.should == 7
      detailed_season.ladder.first.losses.should == 1

      detailed_season.characters.class.should == Array
      detailed_season.characters.first.id.should == 999000
      detailed_season.characters.first.realm.should == 1
      detailed_season.characters.first.display_name.should == 'DayNine'
      detailed_season.characters.first.clan_name.should == 'Team 9'
      detailed_season.characters.first.clan_tag.should == 'Nine'
      detailed_season.characters.first.profile_path.should == '/profile/999000/1/DayNine/'

      detailed_season.non_ranked.class.should == Array
      detailed_season.non_ranked.should == []
    end

    it 'should store the previous_season attributes as underscored' do
      @options = {
        'previousSeason' => [
          {
            'ladder' => [],
            'characters' => [
              {
                'id' => 3113795,
                'realm' => 1,
                'displayName' => 'Smix',
                'clanName' => '',
                'clanTag' => '',
                'profilePath' => '/profile/3113795/1/Smix/'
              }, {
                'id' => 1283116,
                'realm' => 1,
                'displayName' => 'megumixbear',
                'clanName' => '',
                'clanTag' => '',
                'profilePath' => '/profile/1283116/1/megumixbear/'
              }
            ],
            'nonRanked' => [
              {
                'mmq' => 'HOTS_TWOS',
                'gamesPlayed' => 2
              }
            ]
          }, {
            'ladder' => [
              {
                'ladderName' => 'Immortal Romeo',
                'ladderId' => 148509,
                'division' => 120,
                'rank' => 61,
                'league' => 'DIAMOND',
                'matchMakingQueue' => 'HOTS_SOLO',
                'wins' => 11,
                'losses' => 2,
                'showcase' => false
              }
            ],
            'characters' => [
              {
                'id' => 1283116,
                'realm' => 1,
                'displayName' => 'megumixbear',
                'clanName' => '',
                'clanTag' => '',
                'profilePath' => '/profile/1283116/1/megumixbear/'
              }
            ],
            'nonRanked' => []
          }
        ]
      }

      ladder.previous_season.class.should == Array
      ladder.previous_season.each do |ds|
        ds.class.should == Starcraft2::Profile::DetailedSeason
      end

      detailed_season = ladder.previous_season.first
      detailed_season.ladder.class.should == Array
      detailed_season.ladder.should == []

      detailed_season.characters.class.should == Array
      detailed_season.characters.first.id.should == 3113795
      detailed_season.characters.first.realm.should == 1
      detailed_season.characters.first.display_name.should == 'Smix'
      detailed_season.characters.first.clan_name.should == ''
      detailed_season.characters.first.clan_tag.should == ''
      detailed_season.characters.first.profile_path.should == '/profile/3113795/1/Smix/'

      detailed_season.non_ranked.class.should == Array
      detailed_season.non_ranked.first.class.should == Starcraft2::Profile::NonRank
      detailed_season.non_ranked.first.mmq.should == 'HOTS_TWOS'
      detailed_season.non_ranked.first.games_played.should == 2
    end

    it 'should set the showcase_placement' do
      @options = {:showcase_placement => []}
      ladder.showcase_placement.should == []
    end
  end
end

