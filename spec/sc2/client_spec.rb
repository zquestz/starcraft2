require "spec_helper"

describe SC2::Client do
  let(:client) { SC2::Client.new(@options)}

  before do
    @options = {:host => 'us.battle.net'}
  end

  context 'url constants' do
    it 'should store the achievements url' do
      SC2::Client::ACHIEVEMENTS_PATH.should == '/api/sc2/data/achievements'
    end

    it 'should store the rewards url' do
      SC2::Client::REWARDS_PATH.should == '/api/sc2/data/rewards'
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

    it 'should return items of type SC2::Achievement' do
      VCR.use_cassette('achievements') do
        client.achievements.first.class.should == SC2::Achievement
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

    it 'should return items of type SC2::Reward' do
      VCR.use_cassette('rewards') do
        client.rewards.first.class.should == SC2::Reward
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
        member.class.should == SC2::Member
      end
    end

    it 'should build characters within the members' do
      pending

      ladder.each do |member|
        member.character.class.should == SC2::Character
      end
    end

    it 'should return the first grandmaster' do
      ladder.first.should == ""
    end
  end

  describe '.previous_grandmaster_ladder' do

    let(:ladder) do
      VCR.use_cassette('previous_grandmaster') do
        SC2::Client.previous_grandmaster_ladder
      end
    end

    it 'should return an array of members' do
      ladder.class.should == Array
      ladder.each do |member|
        member.class.should == SC2::Member
      end
    end

    it 'should build characters within the members' do
      pending

      ladder.each do |member|
        member.character.class.should == SC2::Character
      end
    end

    it 'should return the first grandmaster' do
      ladder.first.should == ""
    end
  end
end
