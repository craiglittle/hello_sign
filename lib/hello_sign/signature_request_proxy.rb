require 'hello_sign/signature_request_parameters'

module HelloSign
  class SignatureRequestProxy
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(raw_parameters)
      raw_parameters.call(request_parameters = SignatureRequestParameters.new)
      client.post('/signature_request/send', :body => request_parameters.formatted)
    end

  end
end
