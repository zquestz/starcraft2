module Starcraft2
  class Profile
    class SwarmLevels
      attr_accessor :level, :terran, :zerg, :protoss

      def initialize(options = {})
        Utils.load(self, options, {:terran => SwarmRace, :zerg => SwarmRace, :protoss => SwarmRace})
      end
    end
  end
end
