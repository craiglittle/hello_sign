require 'faraday/upload_io'

module HelloSign
  class SignatureRequestParameters
    attr_accessor :title, :subject, :message, :ccs
    attr_writer :signers, :files

    def signers
      @signers.each_with_index.inject({}) do |parameter, (signer, index)|
        signer = {
          :name          => signer[:name],
          :email_address => signer[:email],
          :order         => index
        }
        parameter[index] = signer
        parameter
      end
    end

    def files
      @files.each_with_index.inject({}) do |parameter, (file, index)|
        parameter[index + 1] = upload_io.new(file[:io], file[:mime], file[:name])
        parameter
      end
    end

    def formatted
      {
        :title              => title,
        :subject            => subject,
        :message            => message,
        :cc_email_addresses => ccs,
        :signers            => signers,
        :file               => files
      }
    end

    private

    def upload_io
      Faraday::UploadIO
    end

  end
end
