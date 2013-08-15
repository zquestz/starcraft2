module Starcraft2
  class Profile
    class AchievementItem
      attr_accessor :achievement_id, :completion_date

      def initialize(options = {})
        Utils.load(self, options)
      end

      def self.build(achievement_item_data)
        achievement_item_data.map do |a|
          new(a)
        end
      end
    end
  end
end
