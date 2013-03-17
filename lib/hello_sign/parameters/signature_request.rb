require 'hello_sign/upload_io'

module HelloSign
  module Parameters
    class SignatureRequest
      attr_accessor :title, :subject, :message, :ccs
      attr_writer :signers, :files, :upload_io_source

      def signers
        (@signers || {}).each_with_index.inject({}) do |parameter, (signer, index)|
          signer = {
            name:          signer[:name],
            email_address: signer[:email_address],
            order:         index
          }
          parameter[index] = signer
          parameter
        end
      end

      def files
        (@files || {}).each_with_index.inject({}) do |parameter, (file_data, index)|
          parameter[index + 1] = upload_io_source.new(file_data).upload
          parameter
        end
      end

      def formatted
        {
          title:              title,
          subject:            subject,
          message:            message,
          cc_email_addresses: ccs,
          signers:            signers,
          file:               files
        }
      end

      private

      def upload_io_source
        @upload_io_source || HelloSign::UploadIO
      end

    end
  end
end
