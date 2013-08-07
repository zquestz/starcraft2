require 'spec_helper'

describe SC2::Ladder do
  describe '.initialize' do

    let(:id) { 148200 }
    let(:ladder) { SC2::Ladder.new(id)}

    before do
      VCR.use_cassette('ladder') do
        @raw_ladder_data = HTTParty.get('http://us.battle.net/api/sc2/ladder/' + id).body
      end
    end

    it 'should build an array of members' do
      ladder.class.should == Array
      ladder.each do |member|
        member.class.should == SC2::Member
      end
    end

    it 'should build characters within the members' do
      ladder.each do |member|
        member.character.class.should == SC2::Character
      end
    end
  end
end
