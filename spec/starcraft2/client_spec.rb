require "spec_helper"

describe Starcraft2::Client do
  let(:client) { Starcraft2::Client.new(@options)}

  before do
    @options = {:host => 'us.battle.net'}
  end

  context 'url constants' do
    it 'should store the achievements url' do
      Starcraft2::Client::ACHIEVEMENTS_PATH.should == '/api/sc2/data/achievements'
    end

    it 'should store the rewards url' do
      Starcraft2::Client::REWARDS_PATH.should == '/api/sc2/data/rewards'
    end
  end

  describe '.initialize' do
    it 'should store the locale' do
      @options = { :locale => 'en_US' }
      client.locale.should == 'en_US'
    end

    it 'should store the host' do
      @options = { :host => 'someserver.com'}
      client.host.should == 'someserver.com'
    end
  end

  describe '.achievements' do
    it 'should return an array of achievements' do
      VCR.use_cassette('achievements') do
        client.achievements.class.should == Array
      end
    end

    it 'should return items of type Starcraft2::Achievement' do
      VCR.use_cassette('achievements') do
        client.achievements.first.class.should == Starcraft2::Achievement
      end
    end

    it 'should return achievements in the correct locale' do
      @options.merge!({:locale => 'pt_BR'})

      VCR.use_cassette('achievements') do
        client.achievements.first.title.should == 'TCT Destruidor'
      end
    end
  end

  describe '.rewards' do
    it 'should return an array of rewards' do
      VCR.use_cassette('rewards') do
        client.rewards.class.should == Array
      end
    end

    it 'should return items of type Starcraft2::Reward' do
      VCR.use_cassette('rewards') do
        client.rewards.first.class.should == Starcraft2::Reward
      end
    end

    it 'should return rewards in the correct locale' do
      @options.merge!({:locale => 'pt_BR'})

      VCR.use_cassette('rewards') do
        client.rewards.first.title.should == 'Kachinsky'
      end
    end
  end

  describe '.grandmaster_ladder' do
    let(:ladder) do
      VCR.use_cassette('grandmaster') do
        client.grandmaster_ladder
      end
    end
    let(:member) { ladder.first }

    it 'should return an array of members' do
      ladder.class.should == Array
      ladder.each do |m|
        m.class.should == Starcraft2::Member
      end
    end

    it 'should build characters within the members' do
      ladder.each do |m|
        m.character.class.should == Starcraft2::Character
      end
    end

    it 'should return the first grandmaster' do
      member.character.id == 2778732
      member.character.realm == 1
      member.character.display_name == 'lIlIlIlIlIlI'
      member.character.clan_name == ''
      member.character.clan_tag == ''
      member.character.profile_path == '/profile/2778732/1/lIlIlIlIlIlI/'

      member.points.should == 2362.0
      member.wins.should == 250
      member.losses.should == 101
      member.join_timestamp.should == 1373859935
      member.highest_rank.should == 1
      member.previous_rank.should == 1
      member.favorite_race_p1.should == 'PROTOSS'
    end
  end
end
