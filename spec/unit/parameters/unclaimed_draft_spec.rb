require 'helper'
require 'hello_sign/parameters/unclaimed_draft'

require 'stringio'

describe HelloSign::Parameters::UnclaimedDraft do
  let(:draft_parameters) { HelloSign::Parameters::UnclaimedDraft.new }

  it "interfaces with Faraday::UploadIO properly" do
    draft_parameters.files = [{:name => 'test.txt', :io => StringIO.new('foobar'),  :mime => 'text/plain'}]
    expect(draft_parameters.formatted).to be_a Hash
  end

  describe "#formatted" do
    let(:text_file)        { double('text file') }
    let(:image_file)       { double('image file') }

    before do
      draft_parameters.files = [
        {:name => 'test.txt', :io => 'text file IO object',  :mime => 'text/plain'},
        {:name => 'test.jpg', :io => 'image file IO object', :mime => 'image/jpeg'}
      ]
    end

    it "returns formatted parameters" do
      Faraday::UploadIO.stub(:new).and_return(text_file, image_file)
      expect(draft_parameters.formatted).to eq({:file => {0 => text_file, 1 => image_file}})
    end
  end
end
