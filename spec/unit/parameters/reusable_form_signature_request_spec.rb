require 'helper'
require 'hello_sign/parameters/reusable_form_signature_request'

describe HelloSign::Parameters::ReusableFormSignatureRequest do
  describe "#formatted" do
    let(:request_parameters) { HelloSign::Parameters::ReusableFormSignatureRequest.new }
    let(:expected) do
      {
        :reusable_form_id => 'form_id',
        :title            => 'Lease',
        :subject          => 'Sign this',
        :message          => 'You must sign this.',
        :ccs              => {
          'lawyer'     => {:email_address => 'lawyer@lawfirm.com'},
          'accountant' => {:email_address => 'accountant@llc.com'}
        },
        :signers          => {
          'consultant' => {:name => 'Jack', :email_address => 'jack@hill.com'}, 
          'client'     => {:name => 'Jill', :email_address => 'jill@hill.com'}
        },
        :custom_fields    => {
          'cost' => '$20,000',
          'time' => 'two weeks'
        }
      }
    end

    before do
      request_parameters.reusable_form_id = 'form_id'
      request_parameters.title   = 'Lease'
      request_parameters.subject = 'Sign this'
      request_parameters.message = 'You must sign this.'
      request_parameters.ccs     = [
        {:email => 'lawyer@lawfirm.com', :role => 'lawyer'},
        {:email => 'accountant@llc.com', :role => 'accountant'}
      ]
      request_parameters.signers = [
        {:name => 'Jack', :email => 'jack@hill.com', :role => 'consultant'},
        {:name => 'Jill', :email => 'jill@hill.com', :role => 'client'}
      ]
      request_parameters.custom_fields = [
        {:name => 'cost', :value => '$20,000'},
        {:name => 'time', :value => 'two weeks'}
      ]
    end

    it "returns formatted parameters" do
      expect(request_parameters.formatted).to eq expected
    end
  end
end
