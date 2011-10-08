# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "codeine/version"

Gem::Specification.new do |s|
  s.name        = "codeine"
  s.version     = Codeine::VERSION
  s.authors     = ["Tim Ariyeh"]
  s.email       = ["tim.ariyeh@gmail.com"]
  s.homepage    = "https://github.com/timariyeh/codeine"
  s.summary     = %q{A simple Ruby dependency injector}
  s.description = %q{A really simple, partitionable, ruby-flavored dependency injector}

  s.rubyforge_project = "codeine"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
