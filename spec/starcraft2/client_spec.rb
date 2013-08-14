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

  describe ".initialize" do
    it 'should store the locale' do
      @options = { :locale => 'en_US' }
      client.locale.should == 'en_US'
    end

    it 'should store the host' do
      @options = { :host => 'someserver.com'}
      client.host.should == 'someserver.com'
    end
  end

  describe ".achievements" do
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

    it "should return achievements in the correct locale" do
      @options.merge!({:locale => "pt_BR"})

      VCR.use_cassette('achievements') do
        client.achievements.first.title.should == "TCT Destruidor"
      end
    end
  end

  describe ".rewards" do
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

    it "should return rewards in the correct locale" do
      @options.merge!({:locale => "pt_BR"})

      VCR.use_cassette('rewards') do
        client.rewards.first.title.should == "Kachinsky"
      end
    end
  end

  describe '.grandmaster_ladder' do
    let(:ladder) do
      VCR.use_cassette('grandmaster') do
        client.grandmaster_ladder
      end
    end

    it 'should return an array of members' do
      ladder.class.should == Array
      ladder.each do |member|
        member.class.should == Starcraft2::Member
      end
    end

    it 'should build characters within the members' do
      ladder.each do |member|
        member.character.class.should == Starcraft2::Character
      end
    end

    it 'should return the first grandmaster' do
      # ladder.first.character.should == ""
      ladder.first.points.should == 2352.0
      ladder.first.wins.should == 249
      ladder.first.losses.should == 101
      ladder.first.join_timestamp.should == 1373859935
      ladder.first.highest_rank.should == 1
      ladder.first.previous_rank.should == 11
      ladder.first.favorite_race_p1.should == "PROTOSS"
    end
  end
end