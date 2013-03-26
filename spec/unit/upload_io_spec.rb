require 'helper'
require 'hello_sign/file'

describe HelloSign::File do
  let(:attachment) { double('attachment') }
  let(:io_object)  { double('IO object') }

  it "returns the attachment" do
    Faraday::UploadIO.stub(:new).and_return(attachment)

    expect(HelloSign::File.new(filename: 'test.txt').attachment).to eq attachment
  end

  context "#upload" do
    specify do
      Faraday::UploadIO.should_receive(:new).with('test.txt', 'text/plain')

      HelloSign::File.new(filename: 'test.txt').attachment
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with('test.foo', 'text/plain')

      HelloSign::File.new(filename: 'test.foo').attachment
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with('test.baz', 'fake/mime')

      HelloSign::File.new(filename: 'test.baz', mime: 'fake/mime').attachment
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'text/plain')

      HelloSign::File.new(io: io_object).attachment
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'fake/mime')

      HelloSign::File.new(io: io_object, mime: 'fake/mime').attachment
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'fake/mime', 'test.foo')

      HelloSign::File.new(filename: 'test.foo', io: io_object, mime: 'fake/mime').attachment
    end

    specify do
      Faraday::UploadIO.should_receive(:new).with(io_object, 'text/plain', 'test.foo')

      HelloSign::File.new(filename: 'test.foo', io: io_object).attachment
    end
  end
end
