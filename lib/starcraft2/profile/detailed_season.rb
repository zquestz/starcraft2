module Starcraft2
  class Profile
    class DetailedSeason
      attr_accessor :ladder, :characters, :non_ranked

      def initialize(options = {})
        Utils.load(self, options, {}, {:ladder => Ladder, :characters => ::Starcraft2::Character, :non_ranked => NonRank})
      end

      def self.build(detailed_season)
        detailed_season.map do |ds|
          new(ds)
        end
      end
    end
  end
end