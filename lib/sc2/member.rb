module SC2
  class Member
    attr_accessor :character, :join_timestamp, :points, :wins,
    :losses, :highest_rank, :previous_rank, :favorite_race_p1, :favorite_race_p2, :favorite_race_p3, :favorite_race_p4

    def initialize(options)
      options.each do |k,v|
        v = SC2::Character.new(v) if k.to_sym == :character
        self.send(:"#{k.to_s.underscore}=", v)
      end
    end
  end
end
