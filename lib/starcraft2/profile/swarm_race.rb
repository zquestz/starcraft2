module Starcraft2
  class Profile
    class SwarmRace
      attr_accessor :level, :total_level_xp, :current_level_xp

      def initialize(options = {})
        Utils.load(self, options)
      end
    end
  end
end