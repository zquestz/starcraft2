module SC2
  class Reward
    attr_accessor :title, :id, :icon, :achievement_id

    def initialize(options = {})
      options.each do |k,v|
        self.send(:"#{k}=", v)
      end
    end

    def self.build(raw_data)
      data = JSON.parse(raw_data)
      data['portraits'].map do |reward|
        reward['achievement_id'] = reward.delete('achievementId')
        new(reward)
      end
    end

  end
end
