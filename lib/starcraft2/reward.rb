module Starcraft2
  class Reward
    attr_accessor :title, :id, :icon, :achievement_id

    def initialize(options = {})
      options.each do |k,v|
        self.send(:"#{StringUtils.underscore(k.to_s)}=", v)
      end
    end

    def self.build(rewards_json)
      data = JSON.parse(rewards_json)
      data['portraits'].map do |reward|
        new(reward)
      end
    end
  end
end
