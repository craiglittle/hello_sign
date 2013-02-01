module HelloSign
  module Proxy
    class Team
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(params)
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

      def add_member(params)
        client.post("/team/add_member", :body => body_by_identifier(params))
      end

      def remove_member(params)
        client.post("/team/remove_member", :body => body_by_identifier(params))
      end

      private

      def body_by_identifier(params)
        if email = params[:email]
          {:email_address => email}
        elsif account_id = params[:account_id]
          {:account_id => account_id}
        else
          raise ArgumentError, 'An email address or account ID must be provided.'
        end
      end

    end
  end
end
