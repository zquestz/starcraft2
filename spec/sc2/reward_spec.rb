require "spec_helper"

describe SC2::Reward do
  describe '#build_rewards' do
    let(:rewards) { SC2::Reward.build_rewards(@raw_reward_data)}

    before do
      VCR.use_cassette('rewards') do
        @raw_reward_data = HTTParty.get('http://us.battle.net/api/sc2/data/rewards').body
      end
    end

    it 'should build an array of rewards' do
      rewards.class.should == Array
      rewards.each do |r|
        r.class.should == SC2::Reward
      end
    end
  end

  describe '.initialize' do
    let(:reward) {SC2::Reward.new(@options)}

    before do
      @options = {}
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
      @options = {:icon => {:x => 1, :y => 2, :w => 3, :h => 4, :offset => 0, :url => 'http://example.com'}}
      reward.icon.should == {:x => 1, :y => 2, :w => 3, :h => 4, :offset => 0, :url => 'http://example.com'}
    end

    it "should store the achievement id" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end
  end
end