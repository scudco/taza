# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taza/version"

Gem::Specification.new do |s|
  s.name = "taza"
  s.version = Taza::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["TODO: Write your name"]
  s.email = ["TODO: Write your email address"]
  s.homepage = ""
  s.summary = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "taza"
  s.add_runtime_dependency(%q<taglob>, ["~> 1.1.1"])
  s.add_runtime_dependency(%q<rake>, ["~> 0.8.3"])
  s.add_runtime_dependency(%q<mocha>, ["~> 0.9.3"])
  s.add_runtime_dependency(%q<rspec>, ["~> 1.1.12"])
  s.add_runtime_dependency(%q<rubigen>, ["~> 1.5.6"])
  s.add_runtime_dependency(%q<user-choices>, ["~> 1.1.6.1"])
  s.add_runtime_dependency(%q<Selenium>, ["~> 1.1.14"])
  s.add_runtime_dependency(%q<firewatir>, ["~> 1.2.1"])


  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
