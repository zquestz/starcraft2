require 'spec_helper'

describe Starcraft2::Character do
  describe '.initialize' do
    let(:character) { Starcraft2::Character.new(@options) }

    before do
      @options = {
        'id' => 5,
        'realm' => 'somewhere',
        'displayName' => 'display me',
        'clanName' => 'clan name',
        'clanTag' => 'clan tag',
        'profilePath' => '/some/path'
      }
    end

    it 'should store attributes as underscored' do
      character.id.should == 5
      character.realm.should == 'somewhere'
      character.display_name.should == 'display me'
      character.clan_name.should == 'clan name'
      character.clan_tag.should == 'clan tag'
      character.profile_path.should == '/some/path'
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      character
    end
  end

  describe '#build' do
    let(:characters) { Starcraft2::Character.build(@items) }

    before do
      @items = [
        {'id' => 1},
        {'id' => 2}
      ]
    end

    it 'should build multiple character objects' do
      characters.class.should == Array
      characters.each do |s|
        s.class.should == Starcraft2::Character
      end
    end

    it 'should build items using new' do
      @items.each do |i|
        Starcraft2::Character.should_receive(:new).with(i)
      end

      characters
    end
  end
end