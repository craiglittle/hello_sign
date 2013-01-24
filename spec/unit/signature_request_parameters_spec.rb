require 'helper'
require 'hello_sign/signature_request_parameters'

describe HelloSign::SignatureRequestParameters do
  describe "#formatted" do
    before do
      Faraday::UploadIO.should_receive(:new).with('text file IO object', 'text/plain', 'test.txt').and_return(text_file = stub)
      Faraday::UploadIO.should_receive(:new).with('image file IO object', 'image/jpeg', 'test.jpg').and_return(image_file = stub)

      @request_parameters = HelloSign::SignatureRequestParameters.new

      @request_parameters.title   = 'Lease'
      @request_parameters.subject = 'Sign this'
      @request_parameters.message = 'You must sign this.'
      @request_parameters.ccs     = ['lawyer@lawfirm.com', 'spouse@family.com']
      @request_parameters.signers = [
        {:name => 'Jack', :email => 'jack@hill.com'},
        {:name => 'Jill', :email => 'jill@hill.com'}
      ]
      @request_parameters.files   = [
        {:name => 'test.txt', :io => 'text file IO object', :mime => 'text/plain'},
        {:name => 'test.jpg', :io => 'image file IO object', :mime => 'image/jpeg'}
      ]

      @expected = {
        :title => 'Lease',
        :subject =>'Sign this',
        :message =>'You must sign this.',
        :cc_email_addresses => ['lawyer@lawfirm.com', 'spouse@family.com'],
        :signers => {
          0 => {:name => 'Jack', :email_address => 'jack@hill.com', :order => 0}, 
          1 => {:name => 'Jill', :email_address => 'jill@hill.com', :order => 1}
        },
        :file => {1 => text_file, 2 => image_file}
      }
    end

    it "returns formatted parameters" do
      expect(@request_parameters.formatted).to eq @expected
    end
  end
end
