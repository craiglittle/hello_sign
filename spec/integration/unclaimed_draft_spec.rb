require 'integration/helper'

describe HelloSign do
  context "creating an unclaimed draft" do
    let(:text_io)  { File.new('spec/fixtures/test.txt') }
    let(:image_io) { File.new('spec/fixtures/test.jpg') }

    before { stub_post_with_auth('/unclaimed_draft/create') }

    example do
      HelloSign.unclaimed_draft.create do |draft|
        draft.files = [
          {:name => 'test.txt', :io => text_io,  :mime => 'text/plain'},
          {:name => 'test.jpg', :io => image_io, :mime => 'image/jpeg'}
        ]
      end

      expect(a_post_with_auth('/unclaimed_draft/create')
        .with(:headers => {'Content-Type' => /multipart\/form-data/}, :body => /This is a test upload file\./)
      ).to have_been_made
    end
  end
end
