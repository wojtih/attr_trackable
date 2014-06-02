# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attr_trackable/version'

Gem::Specification.new do |gem|
  gem.name          = "attr_trackable"
  gem.version       = AttrTrackable::VERSION
  gem.authors       = ["Wojtek"]
  gem.email         = ["wojtih@gmail.com"]
  gem.description   = %q{Track attribute changes in AR models}
  gem.summary       = %q{Track attribute changes in AR models}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "database_cleaner", ["1.0.1"]
  gem.add_dependency "activerecord"
end
