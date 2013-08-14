module Starcraft2
  class Character
    attr_accessor :id, :realm, :display_name, :clan_name, :clan_tag, :profile_path

    def initialize(options = {})
      options.each do |k,v|
        self.send(:"#{k.to_s.underscore}=", v)
      end
    end
  end
end