module Starcraft2
  class Profile
    class Ladder
      attr_accessor :ladderName, :ladder_id, :division, :rank, :league, :match_making_queue, :wins, :losses, :showcase

      def initialize(options = {})
        Utils.load(self, options)
      end
    end
  end
end
