require 'hello_sign/file'

module HelloSign
  module Parameters
    class SignatureRequest
      attr_accessor :title, :subject, :message, :ccs
      attr_writer :signers, :files

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
          parameter[index + 1] = HelloSign::File.new(file_data).attachment
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

    end
  end
end
