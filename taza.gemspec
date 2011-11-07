# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taza/version"

Gem::Specification.new do |s|
  s.name = "taza"
  s.version = Taza::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Pedro Nascimento", "Oscar Rieken"]
  s.email = ["pnascimento@gmail.com", "bisbot@gmail.com"]
  s.homepage = "http://github.com/hammernight/taza"
  s.summary = "Taza is a page object framework."
  s.description = ["Taza is a page object framework."]
  s.required_ruby_version     = '>= 1.8.7'
  s.rubyforge_project = "taza"

  s.add_runtime_dependency(%q<rake>, ["~> 0.8.3"])
  s.add_runtime_dependency(%q<mocha>, ["~> 0.9.3"])
  s.add_runtime_dependency(%q<rspec>, ["~> 2.6"])
  s.add_runtime_dependency(%q<rubigen>, ["~> 1.5.6"])
  s.add_runtime_dependency(%q<user-choices>, ["~> 1.1.6.1"])
  s.add_runtime_dependency(%q<Selenium>, ["~> 1.1.14"])
  s.add_runtime_dependency(%q<firewatir>, ["~> 1.2.1"])
  s.add_runtime_dependency(%q<watir-webdriver>, ["~> 0.3.1"])


  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
