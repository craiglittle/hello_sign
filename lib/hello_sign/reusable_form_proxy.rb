module HelloSign
  class ReusableFormProxy
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def list(params = {})
      params = {:page => 1}.merge(params)
      client.get('/reusable_form/list', :params => params)
    end

    def show(form_id)
      client.get("/reusable_form/#{form_id}")
    end

  end
end
