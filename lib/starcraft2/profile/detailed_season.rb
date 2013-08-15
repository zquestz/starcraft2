module Starcraft2
  class Profile
    class DetailedSeason
      attr_accessor :ladder, :characters, :non_ranked

      def initialize(options = {})
        Utils.load(self, options, {}, { :ladder => Ladder, :characters => ::Starcraft2::Character, :non_ranked => NonRank })
      end
    end
  end
end
