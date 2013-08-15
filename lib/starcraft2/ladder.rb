module Starcraft2
  class Ladder
    def self.build(data)
      data['ladderMembers'].map do |member|
        Member.new(member)
      end
    end
  end
end
