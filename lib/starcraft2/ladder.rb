module Starcraft2
  class Ladder
    def self.build(raw_data)
      data = JSON.parse(raw_data)
      data['ladderMembers'].map do |member|
        Member.new(member)
      end
    end
  end
end
