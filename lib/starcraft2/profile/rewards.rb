module Starcraft2
  class Profile
    class Rewards
      attr_accessor :selected, :earned

      def initialize(options = {})
        Utils.load(self, options)
      end
    end
  end
end
