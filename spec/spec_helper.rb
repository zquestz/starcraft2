require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end

require File.join('bundler', 'setup')
require 'rspec'
require 'vcr'
require 'starcraft2'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes, :erb => true, :serialize_with => :yaml }
end
