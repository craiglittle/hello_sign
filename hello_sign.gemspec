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
  gem.description   = %q{A Ruby interface to the HelloSign API.}
  gem.summary       = gem.description
  gem.homepage      = 'http://www.github.com/craiglittle/hello_sign'

  gem.require_paths = ['lib']
  gem.files         += Dir.glob('lib/**/*.rb')
  gem.files         += Dir.glob('spec/**/*')
  gem.test_files    += Dir.glob('spec/**/*')

  gem.add_dependency 'faraday', '~> 0.8.4'
  gem.add_dependency 'faraday_middleware-multi_json', '~> 0.0.5'

  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'webmock', '~> 1.9.0'
  gem.add_development_dependency 'rake', '~> 10.0.3'
end
