require 'hello_sign/proxy/object'

module HelloSign
  module Proxy
    class ReusableForm < Object

      def initialize(client, form_id)
        super(client)

        @form_id = form_id
      end

      def list(params = {})
        @client.get('/reusable_form/list', params: params)
      end

      def show
        @client.get("/reusable_form/#@form_id")
      end

      def grant_access(params = {})
        @client.post("/reusable_form/add_user/#@form_id", body: params)
      end

      def revoke_access(params = {})
        @client.post("/reusable_form/remove_user/#@form_id", body: params)
      end

    end
  end
end
