# HelloSign

A Ruby interface to the HelloSign API.

[![Dependency Status](https://gemnasium.com/craiglittle/hello_sign.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/craiglittle/hello_sign.png)][code_climate]

[gemnasium]: https://gemnasium.com/craiglittle/hello_sign
[code_climate]: https://codeclimate.com/github/craiglittle/hello_sign

## Installation
```ruby
gem install hello_sign
```

## Usage

All responses are returned as JSON.

### Configuration

HelloSign uses HTTP basic authentication to authenticate users.

Configure the client with credentials like this:

```ruby
HelloSign.configure do |hs|
  hs.email    = 'david@bowman.com'
  hs.password = 'space'
end
```

Those credentials then will be used for each request that requires authentication.

### Account

#### Create an account

Authentication is not required.

```ruby
HelloSign.account.create(:email => 'david@bowman.com', :password => 'space')
```

#### Fetch account settings
```ruby
HelloSign.account.settings.show
```

#### Update account settings

Only callback URL is configurable as of right now.

```ruby
HelloSign.account.settings.update(:callback_url => 'http://callmemaybe.com')
```

### Signature requests

#### Send a request

Values for `:io` must be Ruby IO objects (e.g. `text_file_io` and `image_io` below).

```ruby
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
```

#### Send a request using a reusable form

Values for `:io` must be Ruby IO objects (e.g. `text_file_io` and `image_io` below).

```ruby
HelloSign.signature_request.send(:form => 'form_id') do |request|
  request.title         = 'Lease'
  request.subject       = 'Sign this'
  request.message       = 'You must sign this.'
  request.ccs           = [
    {:email => 'lawyer@lawfirm.com', :role => 'lawyer'},
    {:email => 'accountant@llc.com', :role => 'accountant'}
  ]
  request.signers       = [
    {:name => 'Jack', :email => 'jack@hill.com', :role => 'consultant'},
    {:name => 'Jill', :email => 'jill@hill.com', :role => 'client'}
  ]
  request.custom_fields = [
    {:name => 'cost', :value => '$20,000'},
    {:name => 'time', :value => 'two weeks'}
  ]
end
```

#### Fetch the status on a request
```ruby
HelloSign.signature_request.status('33sdf3')
```

#### Fetch a list of all requests

Defaults to page 1 when no page number is provided.

```ruby
HelloSign.signature_request.list # :page => 1
HelloSign.signature_request.list(:page => 5)
```

#### Send a reminder
```ruby
HelloSign.signature_request.remind('34k2j4', :email => 'bob@smith.com')
```

#### Cancel a request
```ruby
HelloSign.signature_request.cancel('233rwer')
```

#### Fetch a final copy
```ruby
HelloSign.signature_request.final_copy('233rwer')
```

### Reusable forms

#### Fetch a list of all forms

Defaults to page 1 when no page number is provided.

```ruby
HelloSign.reusable_form.list # :page => 1
HelloSign.reusable_form.list(:page => 5)
```

#### Fetch details on a form
```ruby
HelloSign.reusable_form.show('34343kdf')
```

#### Grant access to a form
```ruby
HelloSign.reusable_form.grant_access('34343kdf', :email => 'john@david.com')
HelloSign.reusable_form.grant_access('34343kdf', :account_id => '1543')
```

#### Revoke access to a form
```ruby
HelloSign.reusable_form.revoke_access('34343kdf', :email => 'john@david.com')
HelloSign.reusable_form.revoke_access('34343kdf', :account_id => '1543')
```

### Teams

#### Create a team
```ruby
HelloSign.team.create(:name => 'The Browncoats')
```

#### Fetch team details
```ruby
HelloSign.team.show
```

#### Update team details

Only name is configurable as of right now.

```ruby
HelloSign.team.update(:name => 'The Other Guys')
```

#### Delete a team
```ruby
HelloSign.team.destroy
```

#### Add a member to the team
```ruby
HelloSign.team.add_member(:email => 'new@guy.com')
HelloSign.team.add_member(:account_id => '3432')
```

#### Remove a member from the team
```ruby
HelloSign.team.remove_member(:email => 'old@guy.com')
HelloSign.team.remove_member(:account_id => '3323')
```

### Unclaimed drafts

#### Create a draft
```ruby
HelloSign.unclaimed_draft.create do |draft|
  draft.files = [
    {:name => 'test.txt', :io => text_io,  :mime => 'text/plain'},
    {:name => 'test.jpg', :io => image_io, :mime => 'image/jpeg'}
  ]
end
```

## Contributing
Pull requests welcome. Please squash sloppy commits aggressively and follow [Tim Pope's guidelines][tim_pope_guidelines] on commit messages.

[tim_pope_guidelines]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

## Copyright
Copyright (c) 2013 Craig Little. See [LICENSE][license] for details.

[license]: https://github.com/craiglittle/hello_sign/blob/master/LICENSE.md
