module HelloSign
  module Proxy
    class Team
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def create(params = {})
        client.post('/team/create', :body => params)
      end

      def show
        client.get('/team')
      end

      def update(params = {})
        client.post('/team', :body => params)
      end

      def destroy
        client.post('/team/destroy')
      end

      def add_member(params = {})
        client.post("/team/add_member", :body => params)
      end

      def remove_member(params = {})
        client.post("/team/remove_member", :body => params)
      end

    end
  end
end
