# HelloSign

A Ruby interface to the HelloSign API.

Status: Implementing first draft of API (WIP)

## Planned API Design

```ruby
# Account
HelloSign.account.create
HelloSign.account.settings
HelloSign.account.settings.update(:callback_url => 'https://www.example.com')

## Signature requests
HelloSign.signature_requests
HelloSign.signature_request('23afj34')
HelloSign.signature_request.send(
  :title => 'Lease',
  :subject => 'Sign this',
  :message => 'You must sign this.',
  :signers => [
    {:name => 'Jack', :email => 'jack@hill.com'},
    {:name => 'Jill', :email => 'jill@hill.com'}
  ],
  :cc => [
    'lawyer@lawfirm.com',
    'spouse@family.com'
  ]
)
HelloSign.signature_request_with_reusable_form('3j3kdrj').send(
  :title => 'Lease',
  :subject => 'Sign this',
  :message => 'You must sign this.',
  :signers => [
    {:role => 'client', :name => 'Jack', :email => 'jack@hill.com'},
    {:role => 'provider', :name => 'Jill', :email => 'jill@hill.com'}
  ],
  :cc => [
    'lawyer@lawfirm.com',
    'spouse@family.com'
  ],
  :custom_fields => [
    :cost => '$20,000',
    :estimated_time => 'two weeks'
  ]
)
HelloSign.signature_request('233rwer').remind(:email => 'bob@example.com')
HelloSign.signature_request('233rwer').cancel
HelloSign.signature_request('233rwer').final_copy

## Reusable forms
HelloSign.reusable_forms
HelloSign.reusable_form('34343kdf')
HelloSign.reusable_form('34343kdf').add_user(:email => 'john@david.com')
HelloSign.reusable_form('34343kdf').remove_user(:email => 'john@david.com')

## Team
HelloSign.team
HelloSign.team.create(:name => 'The Browncoats')
HelloSign.team.update(:name => 'The Other Guys')
HelloSign.team.destroy
HelloSign.team.add_member(:email => 'new@guy.com')
HelloSign.team.remove_member(:email => 'old@guy.com')

## Unclaimed drafts
HelloSign.unclaimed_draft.create(:files => ['Account.pdf', 'Details.doc'])
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
