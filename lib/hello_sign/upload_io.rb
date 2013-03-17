require 'faraday/upload_io'
require 'hello_sign/error'

module HelloSign
  class UploadIO
    MIME_TYPES = {
      'doc'  => 'application/msword',
      'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'gif'  => 'image/gif',
      'jpg'  => 'image/jpeg',
      'jpeg' => 'image/jpeg',
      'pdf'  => 'application/pdf',
      'png'  => 'image/png',
      'ppsx' => 'application/vnd.openxmlformats-officedocument.presentationml.slideshow',
      'ppt'  => 'application/vnd.ms-powerpoint',
      'pptx' => 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'tif'  => 'image/tiff',
      'tiff' => 'image/tiff',
      'txt'  => 'text/plain',
      'xls'  => 'application/vnd.ms-excel',
      'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    }

    attr_reader :filename, :io_object

    def initialize(file_data)
      @filename  = file_data[:filename]
      @io_object = file_data[:io]
      @mime_type = file_data[:mime]
    end

    def upload
      file_converter_source.new(*parameters)
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

    def file_converter_source
      @file_converter_source || Faraday::UploadIO
    end

  end
end
