module Starcraft2
  class Profile
    class NonRank
      attr_accessor :mmq, :games_played

      def initialize(options = {})
        Utils.load(self, options)
      end
    end
  end
end

