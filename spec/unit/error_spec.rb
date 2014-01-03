require 'helper'
require 'hello_sign/error'

describe HelloSign::Error do
  describe ".from_error_name" do
    %w(
      bad_request
      unauthorized
      forbidden
      not_found
      unknown
      team_invite_failed
      invalid_recipient
      convert_failed
      signature_request_cancel_failed
      maintenance
    ).each do |error_name|
      context "when the error name is #{error_name}" do
        it "returns the proper exception" do
          expect(HelloSign::Error.from_error_name(error_name)).to(
            be(
              HelloSign::Error.const_get(
                error_name.split('_').map(&:capitalize).join
              )
            )
          )
        end
      end
    end

    context "when the error name is unknown" do
      it "returns a generic exception" do
        expect(HelloSign::Error.from_error_name('no_such_error'))
          .to be HelloSign::Error
      end
    end
  end

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

  specify do
    expect { raise HelloSign::Error::Maintenance }.to(
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
