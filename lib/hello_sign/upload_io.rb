require 'hello_sign/upload_io/mime_types'
require 'faraday/upload_io'

module HelloSign
  class UploadIO
    attr_reader :filename, :io_object, :mime_type

    def initialize(file_data)
      @filename  = file_data[:filename]
      @io_object = file_data[:io]
      @mime_type = file_data[:mime]
    end

    def upload
      Faraday::UploadIO.new(*parameters)
    end

    private

    def parameters
      begin
        io_object ? [io_object, mime_type, filename] : [filename, mime_type]
      end.compact
    end

    def mime_type
      @mime_type or begin
        extension = (filename || '').split('.').last
        MIME_TYPES.fetch(extension) { 'text/plain' }
      end
    end

  end
end
