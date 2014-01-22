# coding: utf-8

require File.expand_path('../lib/hello_sign/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'hello_sign'
  gem.version       = HelloSign::VERSION
  gem.authors       = ['Craig Little']
  gem.email         = ['craiglttl@gmail.com']
  gem.description   = %q{A Ruby interface to the HelloSign API}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/craiglittle/hello_sign'
  gem.license       = 'MIT'

  gem.require_paths = ['lib']
  gem.files         = Dir['lib/**/*.rb']
  gem.test_files    = Dir['spec/**/*']

  gem.add_dependency 'faraday',            '~> 0.8.0'
  gem.add_dependency 'faraday_middleware', '~> 0.9'
  gem.add_dependency 'hashie',             '>= 1.0', '< 3.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec',   '~> 2.14'
  gem.add_development_dependency 'webmock', '~> 1.9'
end
