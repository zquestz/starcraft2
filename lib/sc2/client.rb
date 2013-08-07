module SC2
  class Client
    attr_accessor :locale

    def initialize(options)
      @locale = options[:locale]
    end

    def achievements
      []
    end
  end
end
