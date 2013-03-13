require 'helper'
require 'hello_sign/middleware/raise_error'

describe HelloSign::Middleware::RaiseError do
  let(:middleware) { HelloSign::Middleware::RaiseError.new(lambda { |env| Faraday::Response.new(env) }) }

  specify { expect { call_with_error('bad_request') }.to raise_error HelloSign::Error::BadRequest }
  specify { expect { call_with_error('unauthorized') }.to raise_error HelloSign::Error::Unauthorized }
  specify { expect { call_with_error('forbidden') }.to raise_error HelloSign::Error::Forbidden }
  specify { expect { call_with_error('not_found') }.to raise_error HelloSign::Error::NotFound }
  specify { expect { call_with_error('unknown') }.to raise_error HelloSign::Error::Unknown }
  specify { expect { call_with_error('team_invite_failed') }.to raise_error HelloSign::Error::TeamInviteFailed }
  specify { expect { call_with_error('invalid_recipient') }.to raise_error HelloSign::Error::InvalidRecipient }
  specify { expect { call_with_error('convert_failed') }.to raise_error HelloSign::Error::ConvertFailed }
  specify { expect { call_with_error('signature_request_cancel_failed') }.to raise_error HelloSign::Error::SignatureRequestCancelFailed }

  it 'does not blow up if there is not a body' do
    expect { middleware.call({}) }.to_not raise_error
  end

  private

  def call_with_error(error)
    env = {body: {error: {error_name: error}}}
    middleware.call(env)
  end

end
