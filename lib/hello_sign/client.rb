require 'faraday'

module HelloSign
  class Client
    attr_reader :email, :password
    attr_writer :connection

    def initialize(email, password)
      @email    = email
      @password = password
    end

    def post(path, body)
      connection.post(path, body)
    end

    private

    def connection
      @connection ||= Faraday.new(:url => 'https://api.hellosign.com') do |faraday|
        faraday.request  :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

  end
end
