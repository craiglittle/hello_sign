require 'integration/helper'

describe HelloSign do
  context "when sending a signature request" do
    let(:text_file_io)  { File.new('spec/fixtures/test.txt') }
    let(:image_io)      { File.new('spec/fixtures/test.jpg') }

    before do
      stub_post_with_auth('/signature_request/send')
      request = HelloSign.signature_request do |request|
        request.title   = 'Lease'
        request.subject = 'Sign this'
        request.message = 'You must sign this.'
        request.ccs     = ['lawyer@lawfirm.com', 'spouse@family.com']
        request.signers = [
          {:name => 'Jack', :email => 'jack@hill.com'},
          {:name => 'Jill', :email => 'jill@hill.com'}
        ]
        request.files   = [
          {:name => 'test.txt', :io => text_file_io, :mime => 'text/plain'},
          {:name => 'test.jpg', :io => image_io,     :mime => 'image/jpeg'}
        ]
      end
    end

    it "sends a signature request to the HelloSign API" do
      expect(a_post_with_auth('/signature_request/send')
        .with(:headers => {'Content-Type' => /multipart\/form-data/}, :body => /This is a test upload file\./)
      ).to have_been_made
    end
  end
end
