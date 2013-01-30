require 'helper'
require 'json'
require 'hello_sign/client'

describe HelloSign::Client do
  let(:connection) { double('connection') }
  subject(:client) { HelloSign::Client.new('david@bowman.com', 'space') }

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
end
