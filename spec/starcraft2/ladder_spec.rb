require 'spec_helper'

describe Starcraft2::Ladder do
  describe '#build' do
    let(:id) { 148200 }
    let(:host) { 'us.battle.net' }
    let(:ladder) { Starcraft2::Ladder.build(@raw_ladder_data) }

    before do
      VCR.use_cassette("ladder_#{id}") do
        @raw_ladder_data = JSON.parse(WebResource.get("https://us.battle.net/api/sc2/ladder/#{id}").body)
      end
    end

    it 'should build an array of members' do
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
  end
end
