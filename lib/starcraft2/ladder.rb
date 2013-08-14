module Starcraft2
  class Ladder
    def self.build(ladder_json)
      data = JSON.parse(ladder_json)
      data['ladderMembers'].map do |member|
        Member.new(member)
      end
    end
  end
end
