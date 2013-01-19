require 'helper'

describe HelloSign do
  describe "::account" do
    it "returns an account proxy object" do
      expect(HelloSign.account).to be_a HelloSign::AccountProxy
    end
  end
end
