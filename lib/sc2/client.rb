module SC2
  class Client
    ACHIEVEMENTS_PATH = "/api/sc2/data/achievements"

    attr_accessor :locale, :host

    def initialize(options)
      options.each do |k,v|
        self.send(:"#{k}=", v)
      end
    end

    def achievements
      Achievement.build_achievements(achievements_data)
    end

    private

    def achievements_data
      HTTParty.get(achievements_url).body
    end

    def achievements_url
      "http://" + host + ACHIEVEMENTS_PATH
    end
  end
end
