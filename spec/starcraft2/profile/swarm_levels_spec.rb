require 'spec_helper'

describe Starcraft2::Profile::SwarmLevels do
  describe '.initialize' do
    let(:swarm_levels) { Starcraft2::Profile::SwarmLevels.new(@options) }

    before do
      @options = {
        'level' => 10,
        'terran' => {
          'level' => 9,
          'totalLevelXP' => 150000,
          'currentLevelXP' => 8826
        },
        'zerg' => {
          'level' => 9,
          'totalLevelXP' => 150000,
          'currentLevelXP' => 8826
        },
        'protoss' => {
          'level' => 9,
          'totalLevelXP' => 150000,
          'current_level_XP' => 8826
        }
      }
    end

    it 'should store attributes as underscored' do
      swarm_levels.level.should == 10

      swarm_levels.terran.class.should == Starcraft2::Profile::SwarmRace
      swarm_levels.terran.level.should == 9
      swarm_levels.terran.total_level_xp.should == 150000
      swarm_levels.terran.current_level_xp.should == 8826

      swarm_levels.zerg.class.should == Starcraft2::Profile::SwarmRace
      swarm_levels.zerg.level.should == 9
      swarm_levels.zerg.total_level_xp.should == 150000
      swarm_levels.zerg.current_level_xp.should == 8826

      swarm_levels.protoss.class.should == Starcraft2::Profile::SwarmRace
      swarm_levels.protoss.level.should == 9
      swarm_levels.protoss.total_level_xp.should == 150000
      swarm_levels.protoss.current_level_xp.should == 8826
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options, {:terran => Starcraft2::Profile::SwarmRace, :zerg => Starcraft2::Profile::SwarmRace, :protoss => Starcraft2::Profile::SwarmRace})

      swarm_levels
    end
  end
end