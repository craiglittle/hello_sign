require 'hello_sign/response'
require 'faraday'
require 'faraday_middleware'

module HelloSign
  class Connection
    API_ENDPOINT = 'https://api.hellosign.com'.freeze
    API_VERSION  = '3'.freeze

    attr_reader :auth_configuration

    def initialize(&auth_configuration)
      @auth_configuration = auth_configuration
    end

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, options = {})
      request(:post, path, options)
    end

    private

    def request(method, path, options)
      base_connection do |connection|
        auth_configuration.call(connection) unless options[:auth_not_required]
      end.send(method) do |request|
        request.url  "/v#{API_VERSION}#{path}", options[:params]
        request.body = options[:body]
      end.body
    end

    def base_connection
      Faraday.new(connection_options) do |connection|
        yield connection

        connection.request  :multipart
        connection.request  :url_encoded
        connection.response :raise_error
        connection.response :mashify, mash_class: HelloSign::Response
        connection.response :json
        connection.adapter  :net_http
      end
    end

    def connection_options
      {
        url:     API_ENDPOINT,
        headers: {user_agent: "hello_sign gem v#{HelloSign::VERSION}"}
      }
    end

  end
end
