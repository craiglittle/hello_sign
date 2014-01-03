require 'integration/helper'

describe HelloSign do
  let(:any_call) { HelloSign.team.show }

  specify do
    stub_request_with_error('bad_request')
    expect { any_call }.to raise_error HelloSign::Error::BadRequest
  end

  specify do
    stub_request_with_error('unauthorized')
    expect { any_call }.to raise_error HelloSign::Error::Unauthorized
  end

  specify do
    stub_request_with_error('forbidden')
    expect { any_call }.to raise_error HelloSign::Error::Forbidden
  end

  specify do
    stub_request_with_error('not_found')
    expect { any_call }.to raise_error HelloSign::Error::NotFound
  end

  specify do
    stub_request_with_error('unknown')
    expect { any_call }.to raise_error HelloSign::Error::Unknown
  end

  specify do
    stub_request_with_error('team_invite_failed')
    expect { any_call }.to raise_error HelloSign::Error::TeamInviteFailed
  end

  specify do
    stub_request_with_error('invalid_recipient')
    expect { any_call }.to raise_error HelloSign::Error::InvalidRecipient
  end

  specify do
    stub_request_with_error('convert_failed')
    expect { any_call }.to raise_error HelloSign::Error::ConvertFailed
  end

  specify do
    stub_request_with_error('signature_request_cancel_failed')
    expect { any_call }.to raise_error HelloSign::Error::SignatureRequestCancelFailed
  end

  specify do
    stub_request_with_error('maintenance')
    expect { any_call }.to raise_error HelloSign::Error::Maintenance
  end
end
