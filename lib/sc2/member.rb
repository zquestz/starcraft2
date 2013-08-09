module SC2
  class Member
    attr_accessor :character, :join_timestamp, :points, :wins,
    :losses, :highest_rank, :previous_rank, :favorite_race

    def initialize(options)
      options.each do |k,v|
        self.send(:"#{k}=", v)
      end
    end
  end
end
