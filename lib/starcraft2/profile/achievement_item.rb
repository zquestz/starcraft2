module Starcraft2
  class Profile
    class AchievementItem
      attr_accessor :id, :completion_date

      def initialize(options = {})
        Utils.load(self, options)
      end
    end
  end
end
