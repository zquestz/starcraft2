module Starcraft2
  class Profile
    class Points
      attr_accessor :total_points, :category_points

      def initialize(options = {})
        Utils.load(self, options, {:category_points => OpenStruct })
      end
    end
  end
end
