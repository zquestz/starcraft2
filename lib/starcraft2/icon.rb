module Starcraft2
  class Icon
    attr_accessor :x, :y, :w, :h, :offset, :url

    def initialize(options = {})
      Utils.load(self, options)
    end
  end
end