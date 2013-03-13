require 'hello_sign/parameters/unclaimed_draft'

module HelloSign
  module Proxy
    class UnclaimedDraft
      attr_reader :client
      attr_writer :draft_parameters

      def initialize(client)
        @client = client
      end

      def create
        yield draft_parameters
        client.post(
          '/unclaimed_draft/create',
          body: draft_parameters.formatted
        )
      end

      private

      def draft_parameters
        @draft_parameters ||= Parameters::UnclaimedDraft.new
      end

    end
  end
end
