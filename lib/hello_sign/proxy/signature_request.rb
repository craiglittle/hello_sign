require 'hello_sign/parameters/signature_request'
require 'hello_sign/parameters/reusable_form_signature_request'

module HelloSign
  module Proxy
    class SignatureRequest
      attr_reader :client, :request_id

      def initialize(client, request_id)
        @client     = client
        @request_id = request_id
      end

      def deliver(params = {}, &block)
        if form_id = params[:form]
          deliver_request_with_form(form_id, &block)
        else
          deliver_request(&block)
        end
      end

      def status
        client.get("/signature_request/#{request_id}")
      end

      def list(params = {})
        client.get('/signature_request/list', params: {page: 1}.merge(params))

      end

      def remind(params = {})
        client.post(
          "/signature_request/remind/#{request_id}",
          body: {email_address: params.delete(:email)}.merge(params)
        )
      end

      def cancel
        client.post("/signature_request/cancel/#{request_id}")
      end

      def final_copy
        client.get("/signature_request/final_copy/#{request_id}")
      end

      private

      def deliver_request
        yield request_parameters

        client.post(
          '/signature_request/send',
          body: request_parameters.formatted
        )
      end

      def deliver_request_with_form(form_id)
        reusable_form_request_parameters.reusable_form_id = form_id
        yield reusable_form_request_parameters

        client.post(
          '/signature_request/send_with_reusable_form',
          body: reusable_form_request_parameters.formatted
        )
      end

      def request_parameters
        @request_parameters ||= Parameters::SignatureRequest.new
      end

      def reusable_form_request_parameters
        @reusable_form_request_parameters ||=
          Parameters::ReusableFormSignatureRequest.new
      end

    end
  end
end
