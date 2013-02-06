module HelloSign
  module Proxy
    class ReusableForm
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def list(params = {})
        client.get('/reusable_form/list', :params => params)
      end

      def show(form_id)
        client.get("/reusable_form/#{form_id}")
      end

      def grant_access(form_id, params = {})
        client.post("/reusable_form/add_user/#{form_id}", :body => params)
      end

      def revoke_access(form_id, params = {})
        client.post("/reusable_form/remove_user/#{form_id}", :body => params)
      end

    end
  end
end
