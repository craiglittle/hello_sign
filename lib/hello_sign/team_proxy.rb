module HelloSign
  class TeamProxy
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(params = {})
      name = params.fetch(:name)
      client.post('/team/create', :body => {:name => name})
    end

  end
end
