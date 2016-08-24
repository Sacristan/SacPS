# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sacps/version"

Gem::Specification.new do |s|
  s.name = "sacps"
  s.version = SacPS::VERSION
  s.author = "Girts Kesteris"
  s.email = ["girts.kesteris@gmail.com"]
  s.homepage = "https://github.com/Sacristan/SacPS.git"
  s.platform = Gem::Platform::RUBY
  s.summary = "Sacristan Payment Systems"
  s.require_path = "lib"
  s.has_rdoc = false

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rubyforge_project = "sacps"

  s.add_development_dependency 'rake'
  s.add_development_dependency "rspec"
  s.add_development_dependency "priscilla"
  s.add_development_dependency "dotenv"
  s.add_development_dependency "timecop"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-nav"

  s.add_dependency 'activesupport'
  s.add_dependency "builder", '>= 2.0'
  s.add_dependency "nokogiri"
  s.add_dependency "xmldsig", '0.2.5'
  s.add_dependency "rest-client"
end
