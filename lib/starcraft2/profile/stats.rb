module Starcraft2
  class Profile
    class Stats
      attr_accessor :type, :wins, :games

      def initialize(options = {})
        Utils.load(self, options)
      end

      def self.build(stats)
        stats.map do |s|
          new(s)
        end
      end
    end
  end
end
