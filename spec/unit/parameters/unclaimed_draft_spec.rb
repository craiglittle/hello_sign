require 'helper'
require 'hello_sign/parameters/unclaimed_draft'

describe HelloSign::Parameters::UnclaimedDraft do
  describe "#formatted" do
    let(:draft_parameters) { HelloSign::Parameters::UnclaimedDraft.new }
    let(:text_file)        { double('text file') }
    let(:image_file)       { double('image file') }
    let(:expected)         { {:file => {0 => text_file, 1 => image_file}} }

    before do
      Faraday::UploadIO.should_receive(:new).with('text file IO object', 'text/plain', 'test.txt').and_return(text_file)
      Faraday::UploadIO.should_receive(:new).with('image file IO object', 'image/jpeg', 'test.jpg').and_return(image_file)

      draft_parameters.files = [
        {:name => 'test.txt', :io => 'text file IO object',  :mime => 'text/plain'},
        {:name => 'test.jpg', :io => 'image file IO object', :mime => 'image/jpeg'}
      ]
    end

    it "returns formatted parameters" do
      expect(draft_parameters.formatted).to eq expected
    end
  end
end
