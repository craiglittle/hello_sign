require 'faraday/upload_io'

module HelloSign
  module Parameters
    class UnclaimedDraft
      attr_writer :files

      def formatted
        {file: files}
      end

      private

      def files
        @files.each_with_index.inject({}) do |parameter, (file, index)|
          parameter[index] = upload_io.new(file[:io], file[:mime], file[:name])
          parameter
        end
      end

      def upload_io
        Faraday::UploadIO
      end

    end
  end
end
