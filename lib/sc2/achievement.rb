module SC2
  class Achievement
    attr_accessor :title, :description, :achievement_id, :category_id, :points, :icon

    def initialize(options = {})
      options.each do |k,v|
        self.send(:"#{k}=", v)
      end
    end
  end
end