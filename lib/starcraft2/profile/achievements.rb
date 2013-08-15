module Starcraft2
  class Profile
    class Achievements
      attr_accessor :points, :achievements

      def initialize(options = {})
        Utils.load(self, options, { :points => Points }, {:achievements => AchievementItem})
      end
    end
  end
end
