module SC2
  class Client
    attr_accessor :locale
    def initialize(args)
      @locale = args[:locale]
    end 
  end
end
