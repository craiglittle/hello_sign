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

  context "when the content type is application/json" do
    let(:env) { {response_headers: {'Content-Type' => 'application/json'}} }

    it "does not change a nil body" do
      expect(middleware.call(env.merge(body: nil)).env[:body]).to eq nil
    end

    context "and the body is valid JSON" do
      let(:body) { {first: 1, second: 2}.to_json }

      it "parses the body into a hash with symbols as keys" do
        expect(middleware.call(env.merge(body: body)).env[:body])
          .to eq({first: 1, second: 2})
      end
    end
  end

  context "when the content type is not application/json" do
    let(:env) { {response_headers: {'Content-Type' => 'application/pdf'}} }

    it "does not parse the body" do
      expect(middleware.call(env.merge(body: 'dave')).env[:body]).to eq 'dave'
    end
  end
end
