require 'spec_helper'

describe Starcraft2::Profile::DetailedSeason do
  describe '.initialize' do
    let(:detailed_season) { Starcraft2::Profile::DetailedSeason.new(@options) }

    it 'should store attributes as underscored' do
      @options = {
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
        'nonRanked' => []
      }

      detailed_season.ladder.should == []

      detailed_season.characters.class.should == Array
      detailed_season.characters.each do |c|
        c.class.should == Starcraft2::Character
      end

      c1 = detailed_season.characters.first
      c1.id.should == 3113795
      c1.realm.should == 1
      c1.display_name.should == 'Smix'
      c1.clan_name.should == ''
      c1.clan_tag.should == ''
      c1.profile_path.should == '/profile/3113795/1/Smix/'

      c2 = detailed_season.characters.last
      c2.id.should == 1283116
      c2.realm.should == 1
      c2.display_name.should == 'megumixbear'
      c2.clan_name.should == ''
      c2.clan_tag.should == ''
      c2.profile_path.should == '/profile/1283116/1/megumixbear/'

      detailed_season.non_ranked.should == []
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options, {}, {:ladder => Starcraft2::Profile::Ladder, :characters => Starcraft2::Character, :non_ranked => Starcraft2::Profile::NonRank})

      detailed_season
    end
  end

  describe '#build' do
    let(:detailed_seasons) { Starcraft2::Profile::DetailedSeason.build(@items) }

    before do
      @items = [
        {
          'characters' => [
            {'id' => 3113795},
            {'id' => 1283116}
          ]
        },
        {
          'characters' => [
            {'id' => 3113796},
            {'id' => 1283117}
          ]
        }
      ]
    end

    it 'should build multiple detailed seasons' do
      detailed_seasons.class.should == Array
      detailed_seasons.each do |ds|
        ds.class.should == Starcraft2::Profile::DetailedSeason
      end
    end

    it 'should build items using new' do
      @items.each do |i|
        Starcraft2::Profile::DetailedSeason.should_receive(:new).with(i)
      end

      detailed_seasons
    end
  end
end