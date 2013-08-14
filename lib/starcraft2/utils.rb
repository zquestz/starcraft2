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

    def self.load(klass, options, class_map = {})
      options.each do |k, v|
        v = class_map[k.to_sym].new(v) if class_map.keys.include?(k.to_sym)

        klass.send(:"#{self.underscore(k.to_s)}=", v)
      end
    end
  end
end