require 'spec_helper'

describe Starcraft2::Profile::SwarmRace do
  describe '.initialize' do
    let(:swarm_race) { Starcraft2::Profile::SwarmRace.new(@options) }

    before do
      @options = {
        'level' => 5, 'totalLevelXP' => 5000, 'currentLevelXP' => 2
      }
    end

    it 'should store attributes as underscored' do
      swarm_race.level.should == 5
      swarm_race.total_level_xp.should == 5000
      swarm_race.current_level_xp.should == 2
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      swarm_race
    end
  end
end