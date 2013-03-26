require 'helper'
require 'hello_sign/upload_io'

describe HelloSign::UploadIO do
  let(:attachment) { double('attachment') }
  let(:io_object)  { double('IO object') }

  it "returns the attachment" do
    Faraday::UploadIO.stub(:new).and_return(attachment)

    expect(HelloSign::UploadIO.new(filename: 'test.txt').upload).to eq attachment
  end

  context "#upload" do
    specify do
      Faraday::UploadIO.should_receive(:new).with('test.txt', 'text/plain')

      HelloSign::UploadIO.new(filename: 'test.txt').upload
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with('test.foo', 'text/plain')

      HelloSign::UploadIO.new(filename: 'test.foo').upload
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with('test.baz', 'fake/mime')

      HelloSign::UploadIO.new(filename: 'test.baz', mime: 'fake/mime').upload
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'text/plain')

      HelloSign::UploadIO.new(io: io_object).upload
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'fake/mime')

      HelloSign::UploadIO.new(io: io_object, mime: 'fake/mime').upload
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'fake/mime', 'test.foo')

      HelloSign::UploadIO.new(filename: 'test.foo', io: io_object, mime: 'fake/mime').upload
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'text/plain', 'test.foo')

      HelloSign::UploadIO.new(filename: 'test.foo', io: io_object).upload
    end
  end
end
