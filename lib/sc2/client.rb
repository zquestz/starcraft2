module SC2
  class Client
    ACHIEVEMENTS_URL = "http://us.battle.net/api/sc2/data/achievements"
    attr_accessor :locale

    def initialize(options)
      @locale = options[:locale]
    end

    def achievements
      Achievement.build_achievements(achievements_data)
    end

    private

    def achievements_data
      HTTParty.get(ACHIEVEMENTS_URL).body
    end
  end
end
