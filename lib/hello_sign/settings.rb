require 'hello_sign/client'

module HelloSign
  class Settings
    attr_reader :attributes, :client

    def initialize(attributes, client)
      @attributes = attributes
      @client     = client
    end

    def update(attributes)
      client.post('/account', :body => attributes)

      true
    end

  end
end
