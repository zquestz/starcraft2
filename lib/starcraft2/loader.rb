require 'httparty'
require 'json'

base = File.expand_path File.dirname(__FILE__)

Dir[File.join(base, 'errors', '*.rb')].each do |file|
  require file
end

Dir[File.join(base, 'profile', '*.rb')].each do |file|
  require file
end

Dir[File.join(base, '*.rb')].each do |file|
  require file
end