require 'helper'
require 'vcr'
require 'json'
require 'hello_sign'

HelloSign.configure do |hs|
  hs.email_address = 'email address'
  hs.password      = 'password'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/recordings'
  config.hook_into :faraday
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<EMAIL_ADDRESS>') { 'email address' }
  config.filter_sensitive_data('<PASSWORD>') { 'password' }
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

def fixture_file(filename)
  File.open(File.expand_path("spec/fixtures/#{filename}"))
end
