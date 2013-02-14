require 'acceptance/helper'

describe HelloSign, :vcr do
  context "Account" do
    describe "#create" do
      example do
        response = HelloSign.account.create(
          :email_address => 'hello_sign_test@gmail.com',
          :password      => 'password123')

        expect(response[:account][:account_id]).to eq 'f78bf883be7583739b082328ad87133c80dffb71'
      end
    end

    context "Settings" do
      describe "#show" do
        example do
          response = HelloSign.account.settings.show
          expect(response[:account][:account_id]).to eq '2893e15485cc0983c2c805734fdd2475e6b90725'
        end
      end

      describe "#update" do
        example do
          response = HelloSign.account.settings.update(:callback_url => 'http://callmemaybe.com')
          expect(response[:account][:callback_url]).to eq 'http://callmemaybe.com'
        end
      end
    end
  end

  context "Signature Request" do
    describe "#deliver" do
      example do
        response = HelloSign.signature_request.deliver do |request|
          request.title = 'Lease'
          request.subject = 'Sign this lease'
          request.message = 'This is a lease to sign.'
          request.ccs     = ['lawyer@firm.com', 'spouse@family.com']
          request.signers = [
            {:name => 'Jack', :email_address => 'jack@hill.com'},
            {:name => 'Jill', :email_address => 'jill@hill.com'}
          ]
          request.files   = [
            {:name => 'test.txt', :io => fixture_file('test.txt'), :mime => 'text/plain'},
            {:name => 'test.jpg', :io => fixture_file('test.jpg'), :mime => 'image/jpeg'},
          ]
        end

        expect(response[:signature_request][:title]).to eq 'Lease'
      end
    end

    describe "#deliver with reusable form" do
      let(:form) { '0c2e3eb4b996fa6478dee4b1ce11f1013c2370f9' }

      example do
        response = HelloSign.signature_request.deliver(:form => form) do |request|
          request.title = 'Contract from form'
          request.ccs     = [
            {:email_address => 'lawyer@firm.com',   :role => 'Lawyer'},
            {:email_address => 'accoutant@llc.com', :role => 'Accountant'}
          ]
          request.signers = [
            {:name => 'Jack', :email_address => 'jack@hill.com', :role => 'Client'},
            {:name => 'Jill', :email_address => 'jill@hill.com', :role => 'Consultant'}
          ]
          request.custom_fields = [
            {:name => 'Number', :value => '50'},
            {:name => 'Cost',   :value => '$100.00'}
          ]
        end

        expect(response[:signature_request][:title]).to eq 'Contract from form'
      end
    end

    describe "#status" do
      example do
        response = HelloSign.signature_request.status('d5b69a9a5a03904abb1b170410914c213110c409')
        expect(response[:signature_request][:is_complete]).to eq false
      end
    end

    describe "#list" do
      example do
        response = HelloSign.signature_request.list
        expect(response[:signature_requests].first[:title]).to eq 'Contract from form'
      end
    end

    describe "#remind" do
      example do
        response = HelloSign.signature_request.remind(
          'd5b69a9a5a03904abb1b170410914c213110c409',
          :email_address => 'jack@hill.com')

        expect(response[:signature_request][:signatures].first[:last_reminded_at]).to eq 1360829676
      end
    end

    describe "#cancel" do
      example do
        response = HelloSign.signature_request.cancel('d5b69a9a5a03904abb1b170410914c213110c409')
        expect(response).to eq ''
      end
    end

    describe "#final_copy" do
      example do
        response = HelloSign.signature_request.final_copy('23d847daa38fba159716be8eca440e3a4143762c')
        expect(response).to match(/PDF/)
      end
    end
  end

  context "Reusable Form" do
    describe "#list" do
      example do
        response = HelloSign.reusable_form.list
        expect(response[:reusable_forms].first[:title]).to eq 'Contract'
      end
    end

    describe "#show" do
      example do
        response = HelloSign.reusable_form.show('0c2e3eb4b996fa6478dee4b1ce11f1013c2370f9')
        expect(response[:reusable_form][:title]).to eq 'Contract'
      end
    end
  end
end
