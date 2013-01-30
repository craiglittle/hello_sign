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

    def show
      client.get('/team')
    end

    def update(attributes)
      client.post('/team', :body => attributes)
    end

    def destroy
      client.post('/team/destroy')
    end

  end
end
