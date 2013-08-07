require File.join('bundler', 'setup')
require 'rspec'
require 'vcr'
require 'sc2'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end