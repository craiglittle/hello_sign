require 'helper'
require 'hello_sign/parameters/unclaimed_draft'

require 'stringio'

describe HelloSign::Parameters::UnclaimedDraft do
  subject(:draft_parameters) { HelloSign::Parameters::UnclaimedDraft.new }

  describe "#formatted" do
    let(:text_file) { double('text file') }
    let(:image)     { double('image') }

    before do
      draft_parameters.files = [
        @file_data_1 = {filename: 'test.txt', io: text_file, mime: 'text/html'},
        @file_data_2 = {filename: 'test.jpg', io: image, mime: 'image/jpeg'}
      ]

      allow(HelloSign::File).to(
        receive(:new).with(@file_data_1).and_return(text_file)
      )
      allow(HelloSign::File).to(
        receive(:new).with(@file_data_2).and_return(image)
      )
      [text_file, image].each do |file|
        allow(file).to receive(:attachment).and_return(file)
      end
    end

    it "returns formatted parameters" do
      expect(draft_parameters.formatted).to(
        eq({file: {0 => text_file, 1 => image}})
      )
    end
  end
end
