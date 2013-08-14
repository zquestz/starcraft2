require 'spec_helper'

describe Starcraft2::Member do
  describe '.initialize' do
    let(:member) { Starcraft2::Member.new(@options) }
    let(:character) { {
        'id' => 333319,
        'realm' => 1,
        'displayName' => 'NajM',
        'clanName' => '',
        'clanTag' => '',
        'profilePath' => '/profile/333319/1/NajM/'
    } }

    before do
      @options = {}
    end

    it 'should store the character' do
      @options = {:character => character}
      member.character.class.should == Starcraft2::Character

      member.character.id .should == 333319
      member.character.realm.should == 1
      member.character.display_name.should == 'NajM'
      member.character.clan_name.should == ''
      member.character.clan_tag.should == ''
      member.character.profile_path.should == '/profile/333319/1/NajM/'
    end

    it 'should store the join timestamp' do
      @options = {:join_timestamp => 123456}
      member.join_timestamp.should == 123456
    end

    it 'should store the points' do
      @options = {:points => 1234}
      member.points.should == 1234
    end

    it 'should store the wins' do
      @options = {:wins => 123}
      member.wins.should == 123
    end

    it 'should store the losses' do
      @options = {:losses => 12}
      member.losses.should == 12
    end

    it 'should store the highest rank' do
      @options = {:highest_rank => 1}
      member.highest_rank.should == 1
    end

    it 'should store the previous rank' do
      @options = {:previous_rank => 5}
      member.previous_rank.should == 5
    end

    it 'should store the favorite race for player 1' do
      @options = {:favorite_race_p1 => 'Protoss'}
      member.favorite_race_p1.should == 'Protoss'
    end

    it 'should store the favorite race for player 2' do
      @options = {:favorite_race_p2 => 'Protoss'}
      member.favorite_race_p2.should == 'Protoss'
    end

    it 'should store the favorite race for player 3' do
      @options = {:favorite_race_p3 => 'Protoss'}
      member.favorite_race_p3.should == 'Protoss'
    end

    it 'should store the favorite race for player 4' do
      @options = {:favorite_race_p4 => 'Protoss'}
      member.favorite_race_p4.should == 'Protoss'
    end
  end
end
