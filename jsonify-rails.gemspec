# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jsonify-rails/version"

Gem::Specification.new do |s|
  s.name        = "jsonify-rails"
  s.version     = JsonifyRails::VERSION
  s.authors     = ["Bill Siggelkow"]
  s.email       = ["bsiggelkow@me.com"]
  s.homepage    = "http://github.com/bsiggelkow/jsonify-rails"
  s.summary     = %q{Use Jsonify for Rails View templates}
  s.description = s.summary

  s.rubyforge_project = s.name

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'jsonify', "< 0.4.0"
  s.add_dependency "actionpack"

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'json' unless RUBY_VERSION =~ /^1.9/
  s.add_development_dependency 'rails', ENV["RAILS_VERSION"] || ">= 3.1.0"
  
end
