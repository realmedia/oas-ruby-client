# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oas/version"

Gem::Specification.new do |s|
  s.name        = "oas"
  s.version     = Oas::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Damian Caruso"]
  s.email       = ["damian.caruso@gmail.com"]
  s.homepage    = "http://github.com/realmedia/ruby-oas"
  s.summary     = %q{Ruby wrapper for the OAS API}
  s.description = %q{Ruby wrapper for the OAS API}

  s.rubyforge_project = "oas"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "httpclient", "~> 2.2.0.2"
  s.add_dependency "nokogiri", "~> 1.4.4"
  s.add_dependency "savon", "~> 0.9.2"
  
  s.add_development_dependency "rspec", "~> 2.5.0"
  s.add_development_dependency "webmock", "~> 1.6.2"
end
