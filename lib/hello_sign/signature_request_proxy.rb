require 'hello_sign/signature_request_parameters'

module HelloSign
  class SignatureRequestProxy
    attr_reader :client
    attr_writer :request_parameters

    def initialize(client)
      @client = client
    end

    def create(raw_parameters)
      raw_parameters.call(request_parameters)
      client.post('/signature_request/send', :body => request_parameters.formatted)
    end

    def status(request_id)
      client.get("/signature_request/#{request_id}")
    end

    def list(params = {})
      client.get('/signature_request/list', :params => params)
    end

    private

    def request_parameters
      @request_parameters ||= SignatureRequestParameters.new
    end

  end
end
