require 'helper'

describe HelloSign do
  describe "::account" do
    it "returns the Account class" do
      expect(HelloSign.account).to be HelloSign::Account
    end
  end
end
