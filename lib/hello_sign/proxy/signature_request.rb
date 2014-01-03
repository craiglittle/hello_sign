require 'hello_sign/proxy/object'
require 'hello_sign/parameters/signature_request'
require 'hello_sign/parameters/reusable_form_signature_request'

module HelloSign
  module Proxy
    class SignatureRequest < Object

      def initialize(client, request_id)
        super(client)

        @request_id = request_id
      end

      def deliver(params = {}, &block)
        if (form_id = params[:form])
          deliver_request_with_form(form_id, &block)
        else
          deliver_request(&block)
        end
      end

      def status
        @client.get("/signature_request/#@request_id")
      end

      def list(params = {})
        @client.get('/signature_request/list', {
          params: {page: DEFAULT_PAGE}.merge(params)
        })
      end

      def remind(params = {})
        @client.post("/signature_request/remind/#@request_id", {
          body: {email_address: params.delete(:email)}.merge(params)
        })
      end

      def cancel
        @client.post("/signature_request/cancel/#@request_id")
      end

      def final_copy
        @client.get("/signature_request/final_copy/#@request_id")
      end

      private

      def deliver_request
        @client.post('/signature_request/send', {
          body: Parameters::SignatureRequest.new.tap { |p| yield p }.formatted
        })
      end

      def deliver_request_with_form(form_id)
        @client.post('/signature_request/send_with_reusable_form', {
          body:
            Parameters::ReusableFormSignatureRequest.new.tap do |p|
              p.reusable_form_id = form_id
              yield p
            end.formatted
        })
      end

    end
  end
end
