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
        @file_data_1 = {filename: 'test.txt', io: text_file,  mime: 'text/plain'},
        @file_data_2 = {filename: 'test.jpg', io: image, mime: 'image/jpeg'}
      ]
    end

    it "returns formatted parameters" do
      HelloSign::File.should_receive(:new).with(@file_data_1).and_return(text_file)
      HelloSign::File.should_receive(:new).with(@file_data_2).and_return(image)
      [text_file, image].each { |file| file.should_receive(:attachment).and_return(file) }

      expect(draft_parameters.formatted).to eq({file: {0 => text_file, 1 => image}})
    end
  end
end
