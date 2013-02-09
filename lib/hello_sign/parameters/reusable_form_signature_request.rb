module HelloSign
  module Parameters
    class ReusableFormSignatureRequest
      attr_writer :reusable_form_id, :title, :subject, :message, :ccs, :signers, :custom_fields

      def formatted
        {
          :reusable_form_id => reusable_form_id,
          :title            => title,
          :subject          => subject,
          :message          => message,
          :ccs              => ccs,
          :signers          => signers,
          :custom_fields    => custom_fields
        }
      end

      private

      attr_reader :reusable_form_id, :title, :subject, :message

      def ccs
        @ccs.inject({}) do |parameter, cc|
          parameter[cc[:role]] = {:email_address => cc[:email_address]}
          parameter
        end
      end

      def signers
        @signers.inject({}) do |parameter, signer|
          parameter[signer[:role]] = {:name => signer[:name], :email_address => signer[:email_address]}
          parameter
        end
      end

      def custom_fields
        @custom_fields.inject({}) do |parameter, custom_field|
          parameter[custom_field[:name]] = custom_field[:value]
          parameter
        end
      end

    end
  end
end
