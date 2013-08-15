module Starcraft2
  class Utils
    def self.underscore(string)
      word = string.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!('-', '_')
      word.downcase!
      word
    end

    def self.load(klass, options, class_map = {}, build_map = {})
      options.each do |k, v|
        k = self.underscore(k.to_s)
        k = k.to_sym
        v = class_map[k].new(v) if class_map.keys.include?(k)
        v = build_map[k].build(v) if build_map.keys.include?(k)

        klass.send(:"#{k}=", v)
      end
    end
  end
end
