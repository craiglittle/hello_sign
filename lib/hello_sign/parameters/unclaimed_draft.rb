require 'hello_sign/file'

module HelloSign
  module Parameters
    class UnclaimedDraft
      attr_writer :files

      def formatted
        {file: formatted_files}
      end

      private

      def formatted_files
        files.each_with_index.each_with_object({}) do |(file, i), parameter|
          parameter[i] = HelloSign::File.new(file).attachment
        end
      end

      def files
        @files || {}
      end

    end
  end
end
