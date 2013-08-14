module Starcraft2
  class Icon
    attr_accessor :x, :y, :w, :h, :offset, :url

    def initialize(options = {})
      options.each do |k,v|
        self.send(:"#{StringUtils.underscore(k.to_s)}=", v)
      end
    end
  end
end