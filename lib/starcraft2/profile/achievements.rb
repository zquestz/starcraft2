module Starcraft2
  class Profile
    class Achievements
      attr_accessor :points, :achievement_items

      def initialize(options = {})
        Utils.load(self, options, {:points => Points}, { :achievement_items => AchievementItem })
      end
    end
  end
end
