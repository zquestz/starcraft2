require 'spec_helper'

describe SC2::Member do
  describe '.initialize' do
    let(:member) { SC2::Member.new(@options) }

    before do
      VCR.use_cassette('ladder') do
        @raw_ladder_data = HTTParty.get('http://us.battle.net/api/sc2/ladder/' + id).body
      end
    end

    before do
      @options = {}
    end

    it 'should store the character' do
      @options = {:title => 'Test Title'}
      reward.title.should == 'Test Title'
    end

    it 'should store the join Timestamp' do
      @options = {:id => 3}
      reward.id.should == 3
    end

    it 'should store the points' do
      @options = {:icon => {:x => 1, :y => 2, :w => 3, :h => 4, :offset => 0, :url => 'http://example.com'}}
      reward.icon.should == {:x => 1, :y => 2, :w => 3, :h => 4, :offset => 0, :url => 'http://example.com'}
    end

    it "should store the wins" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end

    it "should store the losses" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end

    it "should store the highest rank" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end

    it "should store the previous rank" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end

    it "should store the favorite race" do
      @options = {:achievement_id => 5}
      reward.achievement_id.should == 5
    end
  end
end
