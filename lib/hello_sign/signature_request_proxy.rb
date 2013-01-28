require 'hello_sign/parameters/signature_request'
require 'hello_sign/parameters/reusable_form_signature_request'

module HelloSign
  class SignatureRequestProxy
    attr_reader :client
    attr_writer :request_parameters, :reusable_form_request_parameters

    def initialize(client)
      @client = client
    end

    def send(params = {})
      if form_id = params[:form]
        reusable_form_request_parameters.reusable_form_id = form_id
        yield reusable_form_request_parameters
        client.post(
          '/signature_request/send_with_reusable_form',
          :body => reusable_form_request_parameters.formatted
        )
      else
        yield request_parameters
        client.post('/signature_request/send', :body => request_parameters.formatted)
      end
    end

    def status(request_id)
      client.get("/signature_request/#{request_id}")
    end

    def list(params = {})
      params = {:page => 1}.merge(params)
      client.get('/signature_request/list', :params => params)
    end

    def remind(request_id, parameters = {})
      email = parameters.fetch(:email)
      client.post("/signature_request/remind/#{request_id}", :body => {:email_address => email})
    end

    def cancel(request_id)
      client.post("/signature_request/cancel/#{request_id}")
    end

    def final_copy(request_id)
      client.get("/signature_request/final_copy/#{request_id}")
    end

    private

    def request_parameters
      @request_parameters ||= Parameters::SignatureRequest.new
    end

    def reusable_form_request_parameters
      @reusable_form_request_parameters ||= Parameters::ReusableFormSignatureRequest.new
    end

  end
end
