module HelloSign
  class AccountProxy

    def create(credentials)
      email    = credentials.fetch(:email)
      password = credentials.fetch(:password)

      conn = Faraday.new(:url => 'https://api.hellosign.com') do |faraday|
        faraday.request  :url_encoded
        faraday.adapter Faraday.default_adapter
      end

      conn.post('/v3/account/create', {:email_address => email, :password => password})
    end

  end
end
