require 'helper'

describe HelloSign do
  describe "::account" do
    it "returns an account proxy object" do
      expect(HelloSign.account).to be_an_instance_of HelloSign::AccountProxy
    end
  end
end
