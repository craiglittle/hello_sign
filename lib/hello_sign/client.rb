require 'faraday'
require 'faraday_middleware-multi_json'

module HelloSign
  class Client
    API_ENDPOINT = 'https://api.hellosign.com'
    API_VERSION  = '/v3'

    attr_reader :email, :password
    attr_writer :connection

    def initialize(email, password)
      @email    = email
      @password = password
    end

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    private

    def request(method, path, options)
      connection = options[:unauthenticated] ? unauth_connection : auth_connection
      request = connection.send(method) do |request|
        request.path = "#{API_VERSION}#{path}"
        request.body = options[:body]
      end

      request.body
    end

    def unauth_connection(&auth)
      Faraday.new(:url => API_ENDPOINT) do |faraday|
        auth.call(faraday) if block_given?
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.response :logger
        faraday.response :multi_json, :symbolize_keys => true
        faraday.adapter Faraday.default_adapter
      end
    end

    def auth_connection
      unauth_connection do |faraday|
        faraday.request :basic_auth, email, password
      end
    end

  end
end
