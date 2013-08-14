module Starcraft2
  class Achievement
    attr_accessor :title, :description, :achievement_id, :category_id, :points, :icon

    def initialize(options = {})
      Utils.load(self, options, {:icon => Icon})
    end

    def self.build(achievements_json)
      data = JSON.parse(achievements_json)
      data['achievements'].map do |achievement|
        new(achievement)
      end
    end
  end
end
