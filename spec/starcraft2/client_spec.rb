require "spec_helper"

describe Starcraft2::Client do
  let(:client) { Starcraft2::Client.new(@options) }

  before do
    @options = {:host => 'us.battle.net'}
  end

  context 'url constants' do
    it 'should store the key endpoint paths' do
      Starcraft2::Client::ACHIEVEMENTS_PATH.should == '/api/sc2/data/achievements'
      Starcraft2::Client::REWARDS_PATH.should == '/api/sc2/data/rewards'
      Starcraft2::Client::LADDER_PATH.should == '/api/sc2/ladder/'
    end
  end

  describe '.initialize' do
    it 'should default to us.battle.net' do
      client.host.should == 'us.battle.net'
    end

    it 'should store the locale' do
      @options = {:locale => 'en_US'}
      client.locale.should == 'en_US'
    end

    it 'should store the host' do
      @options = {:host => 'someserver.com'}
      client.host.should == 'someserver.com'
    end
  end

  describe '.profile' do
    it 'should return an sc2 profile' do
      VCR.use_cassette('profile_999000') do
        options = {:character_name => 'DayNine', :id => 999000, :realm => 1}
        profile = client.profile(options)
        profile.class.should == Starcraft2::Profile
        profile.display_name.should == 'DayNine'
        profile.id.should == 999000
      end
    end

    it 'should error with invalid arguments' do
      expect {
        client.profile({})
      }.to raise_error(Starcraft2::MissingArgumentsError, 'Missing Keys: :character_name, :id, :realm')

      expect {
        client.profile({:character_name => 'DayNine'})
      }.to raise_error(Starcraft2::MissingArgumentsError, 'Missing Keys: :id, :realm')
    end
  end

  describe '.achievements' do
    it 'should return an array of achievements' do
      VCR.use_cassette('achievements') do
        achievements = client.achievements
        achievements.class.should == Array
        achievements.each do |a|
          a.class.should == Starcraft2::Achievement
        end
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
        rewards = client.rewards
        rewards.class.should == Array
        rewards.each do |r|
          r.class.should == Starcraft2::Reward
        end
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

    it 'should return an array of members with characters' do
      ladder.class.should == Array
      ladder.each do |m|
        m.class.should == Starcraft2::Member
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

      member.points.should == 2374.0
      member.wins.should == 253
      member.losses.should == 102
      member.join_timestamp.should == 1373859935
      member.highest_rank.should == 1
      member.previous_rank.should == 1
      member.favorite_race_p1.should == 'PROTOSS'
    end
  end

  describe '.last_grandmaster_ladder' do
    let(:ladder) do
      VCR.use_cassette('last_grandmaster') do
        client.last_grandmaster_ladder
      end
    end
    let(:member) { ladder.first }

    it 'should return an array of members with characters' do
      ladder.class.should == Array
      ladder.each do |m|
        m.class.should == Starcraft2::Member
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

      member.points.should == 2374.0
      member.wins.should == 253
      member.losses.should == 102
      member.join_timestamp.should == 1373859935
      member.highest_rank.should == 1
      member.previous_rank.should == 1
      member.favorite_race_p1.should == 'PROTOSS'
    end
  end
end
