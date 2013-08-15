module Starcraft2
  class Profile
    attr_accessor :id, :realm, :display_name, :clan_name, :clan_tag, :profile_path, :portrait,
                  :career, :swarm_levels, :campaign, :season, :rewards, :achievements

    def initialize(options = {})
      Utils.load(self, options, {:portrait => Icon, :career => Career, :swarm_levels => SwarmLevels})
    end
  end
end
