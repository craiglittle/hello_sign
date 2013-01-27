require 'integration/helper'

describe HelloSign do
  context "when sending a signature request" do
    let(:text_file_io)  { File.new('spec/fixtures/test.txt') }
    let(:image_io)      { File.new('spec/fixtures/test.jpg') }

    before do
      stub_post_with_auth('/signature_request/send')
      request = HelloSign.signature_request.send do |request|
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

  context "when fetching a signature request" do
    before do
      stub_get_with_auth('/signature_request/request_id')
      HelloSign.signature_request.status('request_id')
    end

    it "fetches the signature request information from the HelloSign API" do
      expect(a_get_with_auth('/signature_request/request_id')).to have_been_made
    end
  end

  context "when getting a list of signature requests" do
    before do
      stub_get_with_auth('/signature_request/list?page=1')
      HelloSign.signature_request.list
    end

    it "fetches a list of signature requests from the HelloSign API" do
      expect(a_get_with_auth('/signature_request/list?page=1')).to have_been_made
    end
  end
end
