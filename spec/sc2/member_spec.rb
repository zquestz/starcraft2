require 'spec_helper'

describe SC2::Member do
  describe '.initialize' do
    let(:member) { SC2::Member.new(@options) }
    # let(:character) { SC2::Character.new(@options)}

    before do
      @options = {}
    end

    it 'should store the character' do
    # @options = {:character => character}
    end

    it 'should store the join timestamp' do
      @options = { :join_timestamp => 123456 }
      member.join_timestamp.should == 123456
    end

    it 'should store the points' do
      @options = { points: 1234 }
      member.points.should == 1234
    end

    it "should store the wins" do
      @options = { wins: 123 }
      member.wins.should == 123
    end

    it "should store the losses" do
      @options = { losses: 12 }
      member.losses.should == 12
    end

    it "should store the highest rank" do
      @options = { highest_rank: 1 }
      member.highest_rank.should == 1
    end

    it "should store the previous rank" do
      @options = { previous_rank: 5 }
      member.previous_rank.should == 5
    end

    it "should store the favorite race" do
      @options = {:favorite_race => "Protoss"}
      member.favorite_race.should == "Protoss"
    end
  end
end
