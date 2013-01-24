# HelloSign

A Ruby interface to the HelloSign API.

## Features

#### Account
- [x] create

#### Account settings
- [x] get
- [x] update

#### Signature request

- [ ] list
- [ ] get
- [x] send
- [ ] remind
- [ ] cancel
- [ ] final copy

#### Signature request with a reusable form

- [ ] list
- [ ] get
- [ ] send
- [ ] add user
- [ ] remove user

#### Team

- [ ] create
- [ ] get
- [ ] list
- [ ] update
- [ ] destroy
- [ ] add member
- [ ] remove member

#### Unclaimed drafts

- [ ] create

## Usage

### Account creation

```ruby
HelloSign.account.create(:email => 'david@bowman.com', :password => 'space')
```

### Configuration

HelloSign uses HTTP basic authentication to authenticate API calls.

Configure the client like this:

```ruby
HelloSign.configure do |hs|
  hs.email    = 'david@bowman.com'
  hs.password = 'space'
end
```

Your credentials will be passed with each request requiring authentication.

### Account settings

```ruby
## fetch account settings
HelloSign.account.settings

## update account settings (callback URL as of right now)
HelloSign.account.settings.update(:callback_url => 'http://callmemaybe.com')
```

### Signature requests

```ruby
## send a new request
HelloSign.signature_request do |request|
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
```

## Planned API Design

```ruby
## Signature requests

HelloSign.signature_requests

HelloSign.signature_request('23afj34')


## Signature requests with a reusable form

HelloSign.signature_request_with_reusable_form('3j3kdrj') do |request|
  request.title         = 'Lease'
  request.subject       = 'Sign this'
  request.message       = 'You must sign this.'
  request.signers       = [
    {:role => 'client',   :name => 'Jack', :email => 'jack@hill.com'},
    {:role => 'provider', :name => 'Jill', :email => 'jill@hill.com'}
  ]
  request.cc            = ['lawyer@lawfirm.com', 'spouse@family.com']
  request.custom_fields = {
    :cost => '$20,000',
    :estimated_time => 'two weeks'
  }
)

HelloSign.signature_request('233rwer').remind(:email => 'bob@example.com')

HelloSign.signature_request('233rwer').cancel

HelloSign.signature_request('233rwer').final_copy


## Reusable forms

HelloSign.reusable_forms

HelloSign.reusable_form('34343kdf')

HelloSign.reusable_form('34343kdf').add_user(:email => 'john@david.com')

HelloSign.reusable_form('34343kdf').remove_user(:email => 'john@david.com')


## Teams

HelloSign.team

HelloSign.team.create(:name => 'The Browncoats')

HelloSign.team.update(:name => 'The Other Guys')

HelloSign.team.destroy

HelloSign.team.add_member(:email => 'new@guy.com')

HelloSign.team.remove_member(:email => 'old@guy.com')

## Unclaimed drafts

HelloSign.unclaimed_draft.create(:files => ['Account.pdf', 'Details.doc'])
```
