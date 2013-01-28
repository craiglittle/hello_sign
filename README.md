# HelloSign

A Ruby interface to the HelloSign API.

## Features

#### Account
- [x] create

#### Account settings
- [x] get
- [x] update

#### Signature request

- [x] list
- [x] get
- [x] send
- [x] remind
- [x] cancel
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
HelloSign.account.settings.show

## update account settings (callback URL as of right now)
HelloSign.account.settings.update(:callback_url => 'http://callmemaybe.com')
```

### Signature requests

```ruby
## send a new request
HelloSign.signature_request.send do |request|
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

## fetch the status of a signature request
HelloSign.signature_request.status('33sdf3')

## fetch a list of signature requests
HelloSign.signature_request.list # defaults to page 1
HelloSign.signature_request.list(:page => 5)

## send a signature request reminder
HelloSign.signature_request.remind('34k2j4', :email => 'bob@smith.com')

## cancel a signature request
HelloSign.signature_request.cancel('233rwer')
```

## Planned API Design

```ruby
## Signature requests with a reusable form

HelloSign.signature_request.send(:form => '3j3kdrj') do |request|
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

HelloSign.signature_request.final_copy('233rwer')


## Reusable forms

HelloSign.reusable_form.list

HelloSign.reusable_form.show('34343kdf')

HelloSign.reusable_form.add_user('34343kdf', :email => 'john@david.com')

HelloSign.reusable_form.remove_user('34343kdf', :email => 'john@david.com')


## Teams

HelloSign.team.show

HelloSign.team.create(:name => 'The Browncoats')

HelloSign.team.update(:name => 'The Other Guys')

HelloSign.team.destroy

HelloSign.team.add_member(:email => 'new@guy.com')

HelloSign.team.remove_member(:email => 'old@guy.com')

## Unclaimed drafts

HelloSign.unclaimed_draft.create(:files => ['Account.pdf', 'Details.doc'])
```
