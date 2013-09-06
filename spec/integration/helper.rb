require 'helper'
require 'hello_sign'
require 'webmock/rspec'
require 'json'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

HelloSign.configure do |hs|
  hs.email_address = 'david@bowman.com'
  hs.password      = 'foobar'
end

def stub_get(path)
  stub_request(:get, "https://api.hellosign.com/v3#{path}")
end

def stub_post(path)
  stub_request(:post, "https://api.hellosign.com/v3#{path}")
end

def stub_get_with_auth(path)
  stub_request(:get, "https://david@bowman.com:foobar@api.hellosign.com/v3#{path}")
end

def stub_post_with_auth(path)
  stub_request(:post, "https://david@bowman.com:foobar@api.hellosign.com/v3#{path}")
end

def stub_request_with_error(error)
  stub_request(:any, /api\.hellosign\.com/)
    .to_return(
      headers: {'Content-Type' => 'application/json'},
      body:    {error: {error_name: error}}.to_json
    )
end

def a_get(path)
  a_request(:get, "https://api.hellosign.com/v3#{path}")
end

def a_post(path)
  a_request(:post, "https://api.hellosign.com/v3#{path}")
end

def a_get_with_auth(path)
  a_request(:get, "https://david@bowman.com:foobar@api.hellosign.com/v3#{path}")
end

def a_post_with_auth(path)
  a_request(:post, "https://david@bowman.com:foobar@api.hellosign.com/v3#{path}")
end
