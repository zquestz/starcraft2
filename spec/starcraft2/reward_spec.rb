require 'spec_helper'

describe Starcraft2::Reward do
  describe '.initialize' do
    let(:reward) { Starcraft2::Reward.new(@options) }

    before do
      @options = {
        'title' => 'Test Title',
        'id' => 3,
        'icon' => {'x' => 1, 'y' => 2, 'w' => 3, 'h' => 4, 'offset' => 0, 'url' => 'https://example.com'},
        'achievement_id' => 5
      }
    end

    it 'should store attributes as underscored' do
      reward.title.should == 'Test Title'
      reward.id.should == 3
      reward.icon.class.should == Starcraft2::Icon
      reward.icon.x.should == 1
      reward.icon.y.should == 2
      reward.icon.w.should == 3
      reward.icon.h.should == 4
      reward.icon.offset.should == 0
      reward.icon.url.should == 'https://example.com'
      reward.achievement_id.should == 5
    end
  end

  describe '#build' do
    let(:rewards) { Starcraft2::Reward.build(@rewards) }

    before do
      VCR.use_cassette('rewards') do
        @rewards = JSON.parse(WebResource.get('https://us.battle.net/api/sc2/data/rewards').body)
      end
    end

    it 'should build an array of rewards' do
      rewards.class.should == Array
      rewards.each do |r|
        r.class.should == Starcraft2::Reward
      end
    end

    it 'should import the first reward' do
      reward = rewards.first
      reward.title.should == 'Kachinsky'
      reward.id.should == 2951153716
      reward.icon.x.should == 0
      reward.icon.y.should == 0
      reward.icon.w.should == 90
      reward.icon.h.should == 90
      reward.icon.offset.should == 0
      reward.icon.url.should == 'http://media.blizzard.com/sc2/portraits/0-90.jpg'
      reward.achievement_id.should == 0
    end
  end
end
