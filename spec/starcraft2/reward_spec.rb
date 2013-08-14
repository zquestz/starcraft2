require 'spec_helper'

describe Starcraft2::Reward do
  describe '#build' do
    let(:rewards) { Starcraft2::Reward.build(@raw_reward_data) }

    before do
      VCR.use_cassette('rewards') do
        @raw_reward_data = HTTParty.get('https://us.battle.net/api/sc2/data/rewards').body
      end
    end

    it 'should build an array of rewards' do
      rewards.class.should == Array
      rewards.each do |r|
        r.class.should == Starcraft2::Reward
      end
    end
  end

  describe '.initialize' do
    let(:reward) { Starcraft2::Reward.new(@options) }

    before do
      @options = {}
    end

    it 'should import the first reward' do
      VCR.use_cassette('rewards') do
        @reward = Starcraft2::Reward.build(HTTParty.get('https://us.battle.net/api/sc2/data/rewards').body).first
      end

      @reward.title.should == 'Kachinsky'
      @reward.id.should == 2951153716
      @reward.icon.x.should == 0
      @reward.icon.y.should == 0
      @reward.icon.w.should == 90
      @reward.icon.h.should == 90
      @reward.icon.offset.should == 0
      @reward.icon.url.should == 'http://media.blizzard.com/sc2/portraits/0-90.jpg'
      @reward.achievement_id.should == 0
    end

    it 'should store the title' do
      @options = {:title => 'Test Title'}
      reward.title.should == 'Test Title'
    end

    it 'should store the id' do
      @options = {:id => 3}
      reward.id.should == 3
    end

    it 'should store the icon data' do
      @options = {:icon => {'x' => 1, 'y' => 2, 'w' => 3, 'h' => 4, 'offset' => 0, 'url' => 'https://example.com'}}
      reward.icon.x.should == 1
      reward.icon.y.should == 2
      reward.icon.w.should == 3
      reward.icon.h.should == 4
      reward.icon.offset.should == 0
      reward.icon.url.should == 'https://example.com'
    end

    it 'should store the achievement id' do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end
  end
end
