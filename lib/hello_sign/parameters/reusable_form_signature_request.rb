module HelloSign
  module Parameters
    class ReusableFormSignatureRequest
      attr_accessor :reusable_form_id, :title, :subject, :message
      attr_writer :ccs, :signers, :custom_fields

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
    end
  end
end
