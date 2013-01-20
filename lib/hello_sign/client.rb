require 'faraday'

module HelloSign
  class Client
    API_ENDPOINT = 'https://api.hellosign.com'

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
        request.path = path
        request.body = options[:body]
      end

      request.body
    end

    def unauth_connection
      @unauth_connection ||= Faraday.new(:url => API_ENDPOINT) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def auth_connection
      @auth_connection ||= unauth_connection do
        faraday.request :basic_authentication, email, password
      end
    end

  end
end
