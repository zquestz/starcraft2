module Starcraft2
  class Reward
    attr_accessor :title, :id, :icon, :achievement_id

    def initialize(options = {})
      Utils.load(self, options, {:icon => Icon})
    end

    def self.build(data)
      data['portraits'].map do |reward|
        new(reward)
      end
    end
  end
end
