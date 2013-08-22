require 'helper'
require 'hello_sign/error'

describe HelloSign::Error do
  specify do
    expect { raise HelloSign::Error }.to(
      raise_error StandardError
    )
  end

  specify do
    expect { raise HelloSign::Error::BadRequest }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::Unauthorized }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::Forbidden }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::NotFound }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::Unknown }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::TeamInviteFailed }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::InvalidRecipient }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::ConvertFailed }.to(
      raise_error HelloSign::Error
    )
  end

  specify do
    expect { raise HelloSign::Error::SignatureRequestCancelFailed }.to(
      raise_error HelloSign::Error
    )
  end

  describe "#to_s" do
    let(:error) {
      HelloSign::Error.new('This is why an error was received.', 401)
    }

    it "displays a helpful message" do
      expect(error.to_s).to(
        eq '[Status code: 401] This is why an error was received.'
      )
    end
  end
end
