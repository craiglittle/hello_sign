require 'hello_sign/file'
require 'json'

module HelloSign
  module Parameters
    class SignatureRequest
      attr_accessor :title, :subject, :message, :ccs, :test_mode
      private :title, :subject, :message, :ccs, :test_mode

      attr_writer :signers, :files, :form_fields_per_document, :test_mode

      def formatted
        {
          test_mode:                test_mode || 0,
          title:                    title,
          subject:                  subject,
          message:                  message,
          cc_email_addresses:       ccs,
          signers:                  formatted_signers,
          file:                     formatted_files,
          form_fields_per_document: formatted_form_fields_per_document
        }
      end

      private

      def formatted_signers
        signers.each_with_index.each_with_object({}) do |(signer, i), parameter|
          parameter[i + 1] = {
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

      def formatted_form_fields_per_document
        form_fields_per_document.to_json
      end

      def signers
        @signers || {}
      end

      def files
        @files || {}
      end

      def form_fields_per_document
        @form_fields_per_document || []
      end

    end
  end
end
