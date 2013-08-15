module Starcraft2
  class Profile
    class Campaign
      attr_accessor :wol, :hots

      def initialize(options = {})
        Utils.load(self, options)
      end
    end
  end
end