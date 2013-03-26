module HelloSign
  class File
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
  end
end
