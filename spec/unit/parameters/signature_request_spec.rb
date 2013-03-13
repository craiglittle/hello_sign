require 'helper'
require 'hello_sign/parameters/signature_request'

describe HelloSign::Parameters::SignatureRequest do
  describe "#formatted" do
    let(:request_parameters) { HelloSign::Parameters::SignatureRequest.new }
    let(:text_file)          { double('text file') }
    let(:image_file)         { double('image file') }
    context "when all required arguments are set" do
      let(:expected) do
        {
          title: 'Lease',
          subject: 'Sign this',
          message: 'You must sign this.',
          cc_email_addresses: ['lawyer@lawfirm.com', 'spouse@family.com'], # BUGBUG: should have explicit indexes
          signers: {
            0 => {name: 'Jack', email_address: 'jack@hill.com', order: 0}, 
            1 => {name: 'Jill', email_address: 'jill@hill.com', order: 1}
          },
          file: {1 => text_file, 2 => image_file}
        }
      end

      before do
        request_parameters.title   = 'Lease'
        request_parameters.subject = 'Sign this'
        request_parameters.message = 'You must sign this.'
        request_parameters.ccs     = ['lawyer@lawfirm.com', 'spouse@family.com']
        request_parameters.signers = [
          {name: 'Jack', email_address: 'jack@hill.com'},
          {name: 'Jill', email_address: 'jill@hill.com'}
        ]
        request_parameters.files   = [
          {name: 'test.txt', io: 'text file IO object', mime: 'text/plain'},
          {name: 'test.jpg', io: 'image file IO object', mime: 'image/jpeg'}
        ]
      end

      it "returns formatted parameters" do
        Faraday::UploadIO.should_receive(:new).with('text file IO object', 'text/plain', 'test.txt').and_return(text_file)
        Faraday::UploadIO.should_receive(:new).with('image file IO object', 'image/jpeg', 'test.jpg').and_return(image_file)

        expect(request_parameters.formatted).to eq expected
      end
    end

    context "when required parameters are omitted" do
      let(:expected) do
        {
          title:              nil,
          subject:            nil,
          message:            nil,
          cc_email_addresses: nil,
          signers:            {},
          file:               {}
        }
      end

      it "sets default parameters" do
        expect(request_parameters.formatted).to eq expected
      end
    end
  end
end
