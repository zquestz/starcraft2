module SC2
  class Ladder
    def initialize(raw_data)
      data = JSON.parse(raw_data)
      data['ladderMembers'].map do |member|
        member['achievement_id'] = reward.delete('achievementId')
        new(reward)
      end
    end

  end
end
