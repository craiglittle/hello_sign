require 'helper'
require 'hello_sign/middleware/raise_error'

describe HelloSign::Middleware::RaiseError do
  let(:middleware) { HelloSign::Middleware::RaiseError.new(->(env) { Faraday::Response.new(env) }) }

  def self.it_raises_the_proper_exception(error, exception)
    specify { expect { call_with_error(error) }.to raise_error exception }
  end

  {
    'unauthorized'                    => HelloSign::Error::Unauthorized,
    'forbidden'                       => HelloSign::Error::Forbidden,
    'not_found'                       => HelloSign::Error::NotFound,
    'unknown'                         => HelloSign::Error::Unknown,
    'team_invite_failed'              => HelloSign::Error::TeamInviteFailed,
    'invalid_recipient'               => HelloSign::Error::InvalidRecipient,
    'convert_failed'                  => HelloSign::Error::ConvertFailed,
    'signature_request_cancel_failed' => HelloSign::Error::SignatureRequestCancelFailed,
    'unidentified_error'              => HelloSign::Error
  }.each { |error_pair| it_raises_the_proper_exception(*error_pair) }

  it "does not blow up if there is not a body" do
    expect { middleware.call({}) }.to_not raise_error
  end

  context "when raising an exception" do
    let(:expected_message) { "[Status code: 418] I'm a teapot." }

    it "returns the proper message" do
      begin
        call_with_error('bad_request', message: "I'm a teapot.", status_code: 418)
      rescue HelloSign::Error::BadRequest => e
        expect("#{e}").to match /#{Regexp.escape(expected_message)}/
      end
    end
  end

  private

  def call_with_error(error, options = {})
    env = {
      body:     {error: {error_name: error, error_msg: options[:message]}},
      response: {status: options[:status_code]}
    }
    middleware.call(env)
  end

end
