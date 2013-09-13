require 'hello_sign/file'

module HelloSign
  module Parameters
    class SignatureRequest
      attr_accessor :title, :subject, :message, :ccs, :form_fields_per_document
      private :title, :subject, :message, :ccs, :form_fields_per_document

      attr_writer :signers, :files

      def formatted
        {
          title:                    title,
          subject:                  subject,
          message:                  message,
          cc_email_addresses:       ccs,
          signers:                  formatted_signers,
          file:                     formatted_files,
          form_fields_per_document: form_fields_per_document
        }
      end

      private

      def formatted_signers
        signers.each_with_index.each_with_object({}) do |(signer, i), parameter|
          parameter[i] = {
            name:          signer[:name],
            email_address: signer[:email_address],
            order:         i
          }
        end
      end

      def formatted_files
        files.each_with_index.each_with_object({}) do |(file, i), parameter|
          parameter[i + 1] = HelloSign::File.new(file).attachment
        end
      end

      def signers
        @signers || {}
      end

      def files
        @files || {}
      end

    end
  end
end
