require 'hello_sign/file'

module HelloSign
  module Parameters
    class UnclaimedDraft
      attr_writer :files

      def formatted
        {file: files}
      end

      private

      def files
        @files.each_with_index.inject({}) do |parameter, (file_data, index)|
          parameter[index] = HelloSign::File.new(file_data).attachment
          parameter
        end
      end

    end
  end
end
