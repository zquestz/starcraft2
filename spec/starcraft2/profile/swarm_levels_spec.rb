require 'spec_helper'

describe Starcraft2::Profile::SwarmLevels do
  let(:swarm_levels) { Starcraft2::Profile::SwarmLevels.new(@options) }

  before do
    @options = {}
  end

  describe '.initialize' do
    it 'should store the level' do
      @options = {:level => 10}
      swarm_levels.level.should == 10
    end

    it 'should store terran info' do
      @options = {:terran => {:level => 9, :total_level_XP => 150000, :current_level_XP => 8826}}
      swarm_levels.terran.class.should == Starcraft2::Profile::SwarmRace
      swarm_levels.terran.level.should == 9
      swarm_levels.terran.total_level_xp.should == 150000
      swarm_levels.terran.current_level_xp.should == 8826
    end

    it 'should store zerg info' do
      @options = {:zerg => {:level => 9, :total_level_XP => 150000, :current_level_XP => 8826}}
      swarm_levels.zerg.class.should == Starcraft2::Profile::SwarmRace
      swarm_levels.zerg.level.should == 9
      swarm_levels.zerg.total_level_xp.should == 150000
      swarm_levels.zerg.current_level_xp.should == 8826
    end

    it 'should store protoss info' do
      @options = {:protoss => {:level => 9, :total_level_XP => 150000, :current_level_XP => 8826}}
      swarm_levels.protoss.class.should == Starcraft2::Profile::SwarmRace
      swarm_levels.protoss.level.should == 9
      swarm_levels.protoss.total_level_xp.should == 150000
      swarm_levels.protoss.current_level_xp.should == 8826
    end
  end
end