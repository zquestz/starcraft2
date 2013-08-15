module Starcraft2
  class Profile
    class Season
      attr_accessor :season_id, :total_games_this_season, :stats

      def initialize(options={})
        Utils.load(self, options)
      end
    end
  end
end
