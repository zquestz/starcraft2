module Starcraft2
  class Profile
    class NonRank
      attr_accessor :mmq, :games_played

      def initialize(options = {})
        Utils.load(self, options)
      end

      def self.build(non_rank_data)
        non_rank_data.map do |nr|
          new(nr)
        end
      end
    end
  end
end

