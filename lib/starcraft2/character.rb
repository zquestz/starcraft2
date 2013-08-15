module Starcraft2
  class Character
    attr_accessor :id, :realm, :display_name, :clan_name, :clan_tag, :profile_path

    def initialize(options = {})
      Utils.load(self, options)
    end

    def self.build(character_data)
      character_data.map do |c|
        new(c)
      end
    end
  end
end
