require 'helper'
require 'hello_sign/middleware/raise_error'

describe HelloSign::Middleware::RaiseError do
  let(:middleware) { HelloSign::Middleware::RaiseError.new(->(env) { Faraday::Response.new(env) }) }

  def self.it_raises_the_proper_exception(error, exception)
    specify { expect { call_with_error(error) }.to raise_error exception }
  end

  context "when the content type is application/json" do
    {
      'unauthorized'                    => HelloSign::Error::Unauthorized,
      'forbidden'                       => HelloSign::Error::Forbidden,
      'not_found'                       => HelloSign::Error::NotFound,
      'unknown'                         => HelloSign::Error::Unknown,
      'team_invite_failed'              => HelloSign::Error::TeamInviteFailed,
      'invalid_recipient'               => HelloSign::Error::InvalidRecipient,
      'convert_failed'                  => HelloSign::Error::ConvertFailed,
      'signature_request_cancel_failed' => HelloSign::Error::SignatureRequestCancelFailed,
      'maintenance'                     => HelloSign::Error::Maintenance,
      'unidentified_error'              => HelloSign::Error
    }.each { |error_pair| it_raises_the_proper_exception(*error_pair) }

    it "does not blow up if there is not a body" do
      expect { middleware.call({}) }.not_to raise_error
    end

    context "and an exception is raised" do
      it "returns the proper message" do
        begin
          middleware.call(
            call_with_error(
              'bad_request',
              message: "I'm a teapot.",
              status_code: 418
            ).merge(response_headers)
          )
        rescue HelloSign::Error::BadRequest => e
          expect("#{e}").to match(/#{Regexp.escape("[Status code: 418] I'm a teapot")}/)
        end
      end
    end
  end

  context "when the body is not a hash" do
    it "does not blow up" do
      expect { middleware.call(body: 'hal') }.not_to raise_error
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
