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

    def grant_access(form_id, params = {})
      body = if email = params[:email]
        {:email_address => email}
      elsif account_id = params[:account_id]
        {:account_id => account_id}
      else
        raise ArgumentError, 'An email address or account ID must be provided.'
      end

      client.post("/reusable_form/add_user/#{form_id}", :body => body)
    end

    def revoke_access(form_id, params = {})
      body = if email = params[:email]
        {:email_address => email}
      elsif account_id = params[:account_id]
        {:account_id => account_id}
      else
        raise ArgumentError, 'An email address or account ID must be provided.'
      end

      client.post("/reusable_form/remove_user/#{form_id}", :body => body)
    end

  end
end
