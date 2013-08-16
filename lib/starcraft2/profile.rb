module Starcraft2
  class Profile
    attr_accessor :id, :realm, :display_name, :clan_name, :clan_tag, :profile_path, :portrait,
                  :career, :swarm_levels, :campaign, :season, :rewards, :achievements, :client

    def initialize(options = {})
      Utils.load(self, options, {
        :portrait => Icon,
        :campaign => Campaign,
        :career => Career,
        :swarm_levels => SwarmLevels,
        :season => Season,
        :rewards => Rewards,
        :achievements => Achievements
      })
    end

    def self.build(client, data)
      new(data.merge!(:client => client))
    end

    def matches
      client.matches(:character_name => self.display_name, :id => self.id, :realm => self.realm)
    end

    def ladders
      client.ladders(:character_name => self.display_name, :id => self.id, :realm => self.realm)
    end
  end
end
