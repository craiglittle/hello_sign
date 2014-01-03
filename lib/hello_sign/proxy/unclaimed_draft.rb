require 'hello_sign/proxy/object'
require 'hello_sign/parameters/unclaimed_draft'

module HelloSign
  module Proxy
    class UnclaimedDraft < Object

      def create
        @client.post('/unclaimed_draft/create', {
          body: Parameters::UnclaimedDraft.new.tap { |p| yield p }.formatted
        })
      end

    end
  end
end
