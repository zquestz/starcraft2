require 'spec_helper'

describe Starcraft2::Member do
  describe '.initialize' do
    let(:member) { Starcraft2::Member.new(@options) }

    before do
      @options = {
        'character' => {
          'id' => 333319,
          'realm' => 1,
          'displayName' => 'NajM',
          'clanName' => '',
          'clanTag' => '',
          'profilePath' => '/profile/333319/1/NajM/'
        },
        'joinTimestamp' => 123456,
        'points' => 1234,
        'wins' => 123,
        'losses' => 12,
        'highestRank' => 1,
        'previousRank' => 5,
        'favoriteRaceP1' => 'Protoss',
        'favoriteRaceP2' => 'Protoss',
        'favoriteRaceP3' => 'Protoss',
        'favoriteRaceP4' => 'Protoss'
      }
    end

    it 'should store attributes as underscored' do
      member.character.class.should == Starcraft2::Character
      member.character.id.should == 333319
      member.character.realm.should == 1
      member.character.display_name.should == 'NajM'
      member.character.clan_name.should == ''
      member.character.clan_tag.should == ''
      member.character.profile_path.should == '/profile/333319/1/NajM/'

      member.join_timestamp.should == 123456
      member.points.should == 1234
      member.wins.should == 123
      member.losses.should == 12
      member.highest_rank.should == 1
      member.previous_rank.should == 5
      member.favorite_race_p1.should == 'Protoss'
      member.favorite_race_p2.should == 'Protoss'
      member.favorite_race_p3.should == 'Protoss'
      member.favorite_race_p4.should == 'Protoss'
    end
  end
end