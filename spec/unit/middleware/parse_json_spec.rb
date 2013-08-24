require 'helper'
require 'hello_sign/middleware/parse_json'
require 'json'

describe HelloSign::Middleware::ParseJson do
  let(:middleware) do
    HelloSign::Middleware::ParseJson.new(->(env) { Faraday::Response.new(env) })
  end

  it "does not blow up if there is not a body" do
    expect { middleware.call({}) }.not_to raise_error
  end

  it "does not change a nil body" do
    expect(middleware.call(body: nil).env[:body]).to eq nil
  end

  context "when called with a JSON body" do
    before { @env = {body: {first: 1, second: 2}.to_json} }

    it "parses the body into a hash with symbols as keys" do
      expect(middleware.call(@env).env[:body]).to eq({first: 1, second: 2})
    end
  end
end
