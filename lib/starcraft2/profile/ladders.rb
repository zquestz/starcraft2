module Starcraft2
  class Profile
    class Ladders
      attr_accessor :current_season, :previous_season, :showcase_placement

      def initialize(options = {})
        Utils.load(self, options, {}, {:current_season => DetailedSeason, :previous_season => DetailedSeason})
      end
    end
  end
end
