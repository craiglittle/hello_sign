require 'helper'
require 'hello_sign/client'

describe HelloSign::Client do
  let(:connection) { double('connection') }
  subject(:client) { HelloSign::Client.new('david@bowman.com', 'space') }

  before { client.connection = connection }

  describe "#email" do
    it "returns the email address" do
      expect(client.email).to eq 'david@bowman.com'
    end
  end

  describe "#password" do
    it "returns the password" do
      expect(client.password).to eq 'space'
    end
  end

  describe "#get" do
    before { subject.should_receive(:request).with(:get, 'path', {:options => {}}) }

    it "makes a GET request" do
      subject.get('path', :options => {})
    end
  end

  describe "#post" do
    before { subject.should_receive(:request).with(:post, 'path', {:options => {}}) }

    it "makes a POST request" do
      subject.post('path', :options => {})
    end
  end
end
