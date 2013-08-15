module Starcraft2
  class Profile
    class Ladders
      attr_accessor :current_season, :previous_season, :showcase_placement

      def initialize(options = {})
        Utils.load(self, options, {}, {:current_season => DetailedSeason, :previous_season => DetailedSeason})
      end

      def self.build(data)
        data['ladders'].map do |m|
          new(m)
        end
      end
    end
  end
end
