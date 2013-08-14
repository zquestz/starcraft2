require "spec_helper"

describe Starcraft2::Reward do
  describe '#build' do
    let(:rewards) { Starcraft2::Reward.build(@raw_reward_data) }

    before do
      VCR.use_cassette('rewards') do
        @raw_reward_data = HTTParty.get('http://us.battle.net/api/sc2/data/rewards').body
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
        @reward = Starcraft2::Reward.build(HTTParty.get('http://us.battle.net/api/sc2/data/rewards').body).first
      end

      @reward.title.should == "Kachinsky"
      @reward.id.should == 2951153716
      @reward.icon.should == {"x" => 0, "y" => 0, "w" => 90, "h" => 90, "offset" => 0, "url" => "http://media.blizzard.com/sc2/portraits/0-90.jpg"}
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
      @options = {:icon => {"x" => 1, "y" => 2, "w" => 3, "h" => 4, "offset" => 0, "url" => 'http://example.com'}}
      reward.icon.should == {"x" => 1, "y" => 2, "w" => 3, "h" => 4, "offset" => 0, "url" => 'http://example.com'}
    end

    it "should store the achievement id" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end
  end
end
