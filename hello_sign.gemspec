# -*- encoding: utf-8 -*-
#
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hello_sign/version'

Gem::Specification.new do |gem|
  gem.name          = 'hello_sign'
  gem.version       = HelloSign::VERSION
  gem.authors       = ['Craig Little']
  gem.email         = ['craiglttl@gmail.com']
  gem.description   = %q{This is a wrapper written in Ruby for accessing HelloSign's REST API.}
  gem.summary       = %q{a ruby wrapper for the HelloSign API}
  gem.homepage      = 'http://www.github.com/craiglittle/hello_sign'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency('rspec', '~> 2.12.0')
  gem.add_development_dependency('webmock', '~> 1.9.0')
end
