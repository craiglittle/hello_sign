require 'hello_sign/upload_io'

module HelloSign
  module Parameters
    class UnclaimedDraft
      attr_writer :files, :upload_io_source

      def formatted
        {file: files}
      end

      private

      def files
        @files.each_with_index.inject({}) do |parameter, (file_data, index)|
          parameter[index] = upload_io_source.new(file_data).upload
          parameter
        end
      end

      def upload_io_source
        @upload_io_source || HelloSign::UploadIO
      end

    end
  end
end
