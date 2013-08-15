module Starcraft2
  class Profile
    class Ladder
      attr_accessor :ladder_name, :ladder_id, :division, :rank, :league, :match_making_queue, :wins, :losses, :showcase

      def initialize(options = {})
        Utils.load(self, options)
      end

    def self.build(ladder_data)
      ladder_data.map do |l|
        new(l)
      end
    end
  end
end
