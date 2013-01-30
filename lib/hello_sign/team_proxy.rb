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

    def add_member(params = {})
      body = if email = params[:email]
        {:email_address => email}
      elsif account_id = params[:account_id]
        {:account_id => account_id}
      else
        raise ArgumentError, 'An email address or account ID must be provided.'
      end

      client.post("/team/add_member", :body => body)
    end

  end
end
