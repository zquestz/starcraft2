# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.add_dependency 'httparty'
  gem.add_dependency 'json'

  gem.authors       = ["Josh Ellithorpe", "James Fickel", "Jan Hein Hoogstad"]
  gem.email         = ["quest@mac.com"]
  gem.description   = %q{A small SC2 api wrapper}
  gem.summary       = %q{A small SC2 api wrapper}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.name          = "starcraft2"
  gem.require_paths = ["lib"]
  gem.version       = "0.2.0"

  gem.add_development_dependency 'rspec', '~> 2.6.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock', '1.11'
  gem.add_development_dependency 'simplecov'
end
