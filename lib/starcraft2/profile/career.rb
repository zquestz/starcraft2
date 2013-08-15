module Starcraft2
  class Profile
    class Career
      attr_accessor :primary_race, :league, :terran_wins, :protoss_wins, :zerg_wins,
                    :highest1v1_rank, :highest_team_rank, :season_total_games, :career_total_games

      def initialize(options)
        Utils.load(self, options)
      end
    end
  end
end
