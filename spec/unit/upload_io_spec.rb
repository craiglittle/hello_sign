require 'helper'
require 'hello_sign/file'

describe HelloSign::File do
  let(:attachment) { double('attachment') }
  let(:io_object)  { double('IO object') }

  context "#attachment" do
    before { allow(Faraday::UploadIO).to receive(:new).and_return(attachment) }

    it "returns the attachment" do
      expect(HelloSign::File.new(filename: 'test.txt').attachment).to(
        eq attachment
      )
    end

    context "when called with a file with a .txt extension" do
      before { HelloSign::File.new(filename: 'test.txt').attachment }

      it "creates an attachment with a text/plain MIME type" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with('test.txt', 'text/plain')
        )
      end
    end

    context "when called with a file with an unknown extension" do
      before { HelloSign::File.new(filename: 'test.foo').attachment }

      it "creates an attachment with a text/plain MIME type" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with('test.foo', 'text/plain')
        )
      end
    end

    context "when called with a specified MIME type" do
      before do
        HelloSign::File.new(filename: 'test.baz', mime: 'fake/mime').attachment
      end

      it "creates an attachment with the specified MIME type" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with('test.baz', 'fake/mime')
        )
      end
    end

    context "when called with an IO object" do
      before { HelloSign::File.new(io: io_object).attachment }

      it "creates an attachment with a text/plain MIME type" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with(io_object, 'text/plain')
        )
      end
    end

    context "when called with an IO and a specified MIME type" do
      before do
        HelloSign::File.new(io: io_object, mime: 'fake/mime').attachment
      end

      it "creates an attachment with the specified MIME type" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with(io_object, 'fake/mime')
        )
      end
    end

    context "when called with a filename, IO object, and MIME type" do
      before do
        HelloSign::File.new(
          filename: 'test.foo',
          io:       io_object,
          mime:     'fake/mime'
        ).attachment
      end

      it "creates an attachment with the specified information" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with(io_object, 'fake/mime', 'test.foo')
        )
      end
    end

    context "when called with a filename and IO object" do
      before do
        HelloSign::File.new(filename: 'test.foo', io: io_object).attachment
      end

      it "creates an attachment with a text/plain MIME type" do
        expect(Faraday::UploadIO).to(
          have_received(:new).with(io_object, 'text/plain', 'test.foo')
        )
      end
    end
  end
end
