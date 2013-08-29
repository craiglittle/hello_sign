module HelloSign
  module Parameters
    class ReusableFormSignatureRequest
      attr_writer :reusable_form_id, :title, :subject, :message, :ccs, :signers,
        :custom_fields

      def formatted
        {
          reusable_form_id: reusable_form_id,
          title:            title,
          subject:          subject,
          message:          message,
          ccs:              formatted_ccs,
          signers:          formatted_signers,
          custom_fields:    formatted_custom_fields
        }
      end

      private

      attr_reader :reusable_form_id, :title, :subject, :message

      def formatted_ccs
        ccs.each_with_object({}) do |cc, parameter|
          parameter[cc[:role]] = {email_address: cc[:email_address]}
        end
      end

      def formatted_signers
        signers.each_with_object({}) do |signer, parameter|
          parameter[signer[:role]] = {
            name: signer[:name],
            email_address: signer[:email_address]
          }
        end
      end

      def formatted_custom_fields
        custom_fields.each_with_object({}) do |custom_field, parameter|
          parameter[custom_field[:name]] = custom_field[:value]
        end
      end

      def ccs
        @ccs || {}
      end

      def signers
        @signers || {}
      end

      def custom_fields
        @custom_fields || {}
      end

    end
  end
end
