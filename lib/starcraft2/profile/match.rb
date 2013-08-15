module Starcraft2
  class Profile
    class Match
      attr_accessor :map, :type, :decision, :speed, :date

      def initialize(options = {})
        Utils.load(self, options)
      end

      def self.build(data)
        data['matches'].map do |m|
          new(m)
        end
      end
    end
  end
end
