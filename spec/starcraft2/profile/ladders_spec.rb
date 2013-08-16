require 'spec_helper'

describe Starcraft2::Profile::Ladders do
  let(:ladder) { Starcraft2::Profile::Ladders.new(@options)}

  before do
    @options = {}
  end

  it 'should store the current_season attributes as underscored' do
    @options = { 'current_season' => [{
                 'ladder' => [{
                   'ladderName' => 'Shuttle Tango',
                   'ladderId' => 153300,
                   'division' => 34,
                   'rank' => 28,
                   'league' => 'PLATINUM',
                   'matchMakingQueue' => 'HOTS_TWOS',
                   'wins' => 7,
                   'losses' => 1,
                   'showcase' => true
                 }],
                 'characters' => [{
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
                 }],
                 'nonRanked' => []
               }, {
                 'ladder' => [{
                   'ladderName' => 'Torrasque Upsilon',
                   'ladderId' => 154764,
                   'division' => 59,
                   'rank' => 90,
                   'league' => 'PLATINUM',
                   'matchMakingQueue' => 'HOTS_TWOS',
                   'wins' => 4,
                   'losses' => 1,
                   'showcase' => true
                 }],
                 'characters' => [{
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
                 }],
                 'nonRanked' => []
               }]}
    ladder.current_season.class.should == Array
    ladder.current_season.first.class.should == Starcraft2::Profile::DetailedSeason
    ladder.current_season.first.ladder.class.should == Array
    ladder.current_season.first.ladder.first.class.should == Starcraft2::Profile::Ladder

    ladder.current_season.first.ladder.first.ladder_name.should == 'Shuttle Tango'
    ladder.current_season.first.ladder.first.ladder_id.should == 153300
    ladder.current_season.first.ladder.first.division.should == 34
    ladder.current_season.first.ladder.first.rank.should == 28
    ladder.current_season.first.ladder.first.league.should == 'PLATINUM'
    ladder.current_season.first.ladder.first.match_making_queue.should == 'HOTS_TWOS'
    ladder.current_season.first.ladder.first.wins.should == 7
    ladder.current_season.first.ladder.first.losses.should == 1

    ladder.current_season.first.characters.class.should == Array
    ladder.current_season.first.characters.first.id.should == 999000
    ladder.current_season.first.characters.first.realm.should == 1
    ladder.current_season.first.characters.first.display_name.should == 'DayNine'
    ladder.current_season.first.characters.first.clan_name.should == 'Team 9'
    ladder.current_season.first.characters.first.clan_tag.should == 'Nine'
    ladder.current_season.first.characters.first.profile_path.should == '/profile/999000/1/DayNine/'

    ladder.current_season.first.non_ranked.class.should == Array
    ladder.current_season.first.non_ranked.should == []
  end

  it 'should store the previous_season attributes as underscored' do
    @options = { 'previous_season' => [{
                 'ladder' => [],
                 'characters' => [{
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
                 }],
                 'nonRanked' => [{
                   'mmq' => 'HOTS_TWOS',
                   'gamesPlayed' => 2
                 }]
               }, {
                 'ladder' => [{
                   'ladderName' => 'Immortal Romeo',
                   'ladderId' => 148509,
                   'division' => 120,
                   'rank' => 61,
                   'league' => 'DIAMOND',
                   'matchMakingQueue' => 'HOTS_SOLO',
                   'wins' => 11,
                   'losses' => 2,
                   'showcase' => false
                 }],
                 'characters' => [{
                   'id' => 1283116,
                   'realm' => 1,
                   'displayName' => 'megumixbear',
                   'clanName' => '',
                   'clanTag' => '',
                   'profilePath' => '/profile/1283116/1/megumixbear/'
                 }],
                 'nonRanked' => []
               }]
               }

    ladder.previous_season.class.should == Array
    ladder.previous_season.first.class.should == Starcraft2::Profile::DetailedSeason
    ladder.previous_season.first.ladder.class.should == Array
    ladder.previous_season.first.ladder.should == []

    ladder.previous_season.first.characters.class.should == Array
    ladder.previous_season.first.characters.first.id.should == 3113795
    ladder.previous_season.first.characters.first.realm.should == 1
    ladder.previous_season.first.characters.first.display_name.should == 'Smix'
    ladder.previous_season.first.characters.first.clan_name.should == ''
    ladder.previous_season.first.characters.first.clan_tag.should == ''
    ladder.previous_season.first.characters.first.profile_path.should == '/profile/3113795/1/Smix/'

    ladder.previous_season.first.non_ranked.class.should == Array
    ladder.previous_season.first.non_ranked.first.class.should == Starcraft2::Profile::NonRank

    ladder.previous_season.first.non_ranked.first.mmq.should == 'HOTS_TWOS'
    ladder.previous_season.first.non_ranked.first.games_played.should == 2
  end

  it 'should set the showcase_placement' do
    @options = { :showcase_placement => []}
    ladder.showcase_placement.should == []
  end

  describe '#build' do
    let(:ladders) { Starcraft2::Profile::Ladders.new(@items) }

    before do
      @options = { :current_season => {'characters' => [{ 'displayName' => 'Idra'}, {'displayName' => 'MC'}], 'nonRanked' => [{'mmq' => 'HOTS_TWOS'}]}}
    end

    it 'should build multiple characters using new' do
      ladders.characters.class.should == Array
      ladders.characters.each do |c|
        Starcraft2::Profile::Character.should_receive(:new).with(c)
      end
      ladders
    end

    it 'should build non_ranked using new' do
      ladders.non_ranked.class.should == Array
      ladders.non_ranked.each do |nr|
        Starcraft2::Profile::NonRank.should_receive(:new).with(nr)
      end
      ladders
    end
  end
end
