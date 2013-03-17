require 'helper'
require 'hello_sign/upload_io'

describe HelloSign::UploadIO do
  let(:upload_file) { double('upload file') }
  let(:io_object)   { double('IO object') }
  let(:file_converter_source) { double('file converter source') }

  before { HelloSign::UploadIO.any_instance.stub(:file_converter_source).and_return(file_converter_source) }

  it "returns the upload file" do
    file_converter_source.stub(:new).and_return(upload_file)

    expect(HelloSign::UploadIO.new(filename: 'test.txt').upload).to eq upload_file
  end

  context "#upload" do
    specify do
      file_converter_source.should_receive(:new).with('test.txt', 'text/plain')

      HelloSign::UploadIO.new(filename: 'test.txt').upload
    end

    specify do
      file_converter_source.should_receive(:new).with('test.foo', 'text/plain')

      HelloSign::UploadIO.new(filename: 'test.foo').upload
    end

    specify do
      file_converter_source.should_receive(:new).with('test.baz', 'fake/mime')

      HelloSign::UploadIO.new(filename: 'test.baz', mime: 'fake/mime').upload
    end

    specify do
      file_converter_source.should_receive(:new).with(io_object, 'text/plain')

      HelloSign::UploadIO.new(io: io_object).upload
    end

    specify do
      file_converter_source.should_receive(:new).with(io_object, 'fake/mime')

      HelloSign::UploadIO.new(io: io_object, mime: 'fake/mime').upload
    end

    specify do
      file_converter_source.should_receive(:new).with(io_object, 'fake/mime', 'test.foo')

      HelloSign::UploadIO.new(filename: 'test.foo', io: io_object, mime: 'fake/mime').upload
    end

    specify do
      file_converter_source.should_receive(:new).with(io_object, 'text/plain', 'test.foo')

      HelloSign::UploadIO.new(filename: 'test.foo', io: io_object).upload
    end
  end
end
