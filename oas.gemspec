# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oas/version"

Gem::Specification.new do |s|
  s.name        = "oas"
  s.version     = OAS::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Damian Caruso"]
  s.email       = ["damian.caruso@gmail.com"]
  s.homepage    = "http://github.com/realmedia/oas-ruby-client"
  s.summary     = %q{Ruby client for the OpenAdstream API}
  s.description = %q{Ruby client for the OpenAdstream API}

  s.rubyforge_project = "oas"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "nokogiri", "~> 1.5"
  s.add_dependency "savon", "~> 2.0"
  s.add_dependency "nori", "~> 2.0"
  s.add_dependency "scrivener", "~> 0.0.3"
  
  s.add_development_dependency "minitest", "~> 4.3"
  s.add_development_dependency "webmock", "~> 1.9"
  s.add_development_dependency "rake"
  s.add_development_dependency "simplecov"
end
