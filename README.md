# HelloSign

A Ruby interface to the HelloSign API.

[![Gem Version](https://badge.fury.io/rb/hello_sign.png)][gem_version]
[![Build Status](https://travis-ci.org/craiglittle/hello_sign.png?branch=master)][build_status]
[![Dependency Status](https://gemnasium.com/craiglittle/hello_sign.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/craiglittle/hello_sign.png)][code_climate]
[![Coverage Status](https://coveralls.io/repos/craiglittle/hello_sign/badge.png?branch=master)][coveralls]

[gem_version]: http://badge.fury.io/rb/hello_sign
[build_status]: https://travis-ci.org/craiglittle/hello_sign
[gemnasium]: https://gemnasium.com/craiglittle/hello_sign
[code_climate]: https://codeclimate.com/github/craiglittle/hello_sign
[coveralls]: https://coveralls.io/r/craiglittle/hello_sign


## Installation
```ruby
gem install hello_sign
```

## Configuration

HelloSign uses the [HTTP Basic Access Authentication][http_basic] scheme to authenticate API users.

To configure the client, simply execute the following with your credentials:

```ruby
HelloSign.configure do |hs|
  hs.email_address = 'david@bowman.com'
  hs.password      = 'hal_9000'
end
```

Those credentials will be used when making each request that requires authentication.

[http_basic]: http://en.wikipedia.org/wiki/Basic_access_authentication

### Thread safety

Applications that make requests on behalf of multiple HelloSign users should
avoid global configuration. Instead, instantiate a client directly.

```ruby
hello_sign = HelloSign::Client.new(email_address: 'david@bowman.com', password: 'hal_9000')
```

A client instantiated in this way responds to the same methods as the
`HelloSign` constant.

## Usage

All JSON-encoded responses from the HelloSign API are converted to a hash equivalent with symbols for keys before being returned.

### [Account](http://www.hellosign.com/api/reference#Account)

#### Create an account

```ruby
HelloSign.account.create(email_address: 'david@bowman.com', password: 'hal_9000')
```

Authentication is not required to make this request.

#### Fetch account settings

```ruby
HelloSign.account.settings.show
```

#### Update account settings

```ruby
HelloSign.account.settings.update(callback_url: 'https://callmemaybe.com')
```

### [Signature requests](http://www.hellosign.com/api/reference#SignatureRequest)

#### Send a request

```ruby
HelloSign.signature_request.deliver do |request|
  request.title   = 'Contract'
  request.subject = 'Here is the contract for you to sign!'
  request.message = 'You should definitely sign this.'
  request.ccs     = ['lawyer@lawfirm.com', 'spouse@family.com']
  request.signers = [
    {name: 'Jack', email_address: 'jack@hill.com'},
    {name: 'Jill', email_address: 'jill@hill.com'}
  ]
  request.files   = [
    {filename: 'path/to/contract.pdf'},
    {filename: 'details.txt', io: text_file},
    {filename: 'path/to/directions.txt', mime: 'text/xml'},
    {io: image, mime: 'image/jpeg'}
  ]
end
```

##### Specifying files

There are a couple ways to specify a file when sending a signature request:

* Provide a path to the file's location on disk using `filename`.
* Pass a Ruby IO object using `io` (e.g. `text_file` and `image` above).

Other things to keep in mind:

* If a `filename` isn't provided, a generic one will be inferred.
* If no `mime` key is specified, the MIME type will be inferred by the file extension. If a MIME type cannot be inferred, it will default to `text/plain`.
* When using any method of file specification, the MIME type can always be overriden using the `mime` key.

#### Send a request using a reusable form

```ruby
HelloSign.signature_request.deliver(form: 'form_id') do |request|
  request.title         = 'Contract'
  request.subject       = 'Here is the contract for you to sign!'
  request.message       = 'You should definitely sign this.'
  request.ccs           = [
    {email_address: 'lawyer@lawfirm.com', role: 'lawyer'},
    {email_address: 'accountant@llc.com', role: 'accountant'}
  ]
  request.signers       = [
    {name: 'Jack', email_address: 'jack@hill.com', role: 'consultant'},
    {name: 'Jill', email_address: 'jill@hill.com', role: 'client'}
  ]
  request.custom_fields = [
    {name: 'cost', value: '$20,000'},
    {name: 'time', value: 'two weeks'}
  ]
end
```

#### Fetch the status on a request
```ruby
HelloSign.signature_request('abc123').status
```

#### Fetch a list of all requests

```ruby
HelloSign.signature_request.list
HelloSign.signature_request.list(page: 5)
```

Defaults to page one when no page number is provided.

#### Send a reminder
```ruby
HelloSign.signature_request('abc123').remind(email_address: 'bob@smith.com')
```

#### Cancel a request
```ruby
HelloSign.signature_request('abc123').cancel
```

#### Fetch a final copy
```ruby
HelloSign.signature_request('abc123').final_copy
```

### [Reusable forms](http://www.hellosign.com/api/reference#ReusableForm)

#### Fetch a list of all forms

```ruby
HelloSign.reusable_form.list
HelloSign.reusable_form.list(page: 5)
```

Defaults to page one when no page number is provided.

#### Fetch details on a form
```ruby
HelloSign.reusable_form('abc123').show
```

#### Grant access to a form
```ruby
HelloSign.reusable_form('abc123').grant_access(email_address: 'bob@smith.com')
HelloSign.reusable_form('abc123').grant_access(account_id: '123456')
```

#### Revoke access to a form
```ruby
HelloSign.reusable_form('abc123').revoke_access(email_address: 'bob@smith.com')
HelloSign.reusable_form('abc123').revoke_access(account_id: '123456')
```

### [Teams](http://www.hellosign.com/api/reference#Team)

#### Create a team
```ruby
HelloSign.team.create(name: 'The Browncoats')
```

#### Fetch team details
```ruby
HelloSign.team.show
```

#### Update team details
```ruby
HelloSign.team.update(name: 'The Reavers')
```

#### Delete a team
```ruby
HelloSign.team.destroy
```

#### Add a member to the team
```ruby
HelloSign.team.add_member(email_address: 'new@person.com')
HelloSign.team.add_member(account_id: '123456')
```

#### Remove a member from the team
```ruby
HelloSign.team.remove_member(email_address: 'old@person.com')
HelloSign.team.remove_member(account_id: '123456')
```

### [Unclaimed drafts](http://www.hellosign.com/api/reference#UnclaimedDraft)

#### Create a draft
```ruby
HelloSign.unclaimed_draft.create do |draft|
  draft.files = [
    {filename: 'path/to/test.txt'},
    {filename: 'test.jpg', io: image}
  ]
end
```

See the related [notes](#specifying-files) on specifying files.

## [Errors](http://www.hellosign.com/api/reference#Errors)

When an error is returned from the HelloSign API, an associated exception is raised.

## Supported Ruby interpreters

This gem officially supports and is tested against the following Ruby interpreters:

* MRI 1.9.2
* MRI 1.9.3
* MRI 2.0.0
* JRuby in 1.9 mode
* Rubinius in 1.9 mode
* Rubinius in 2.0 mode


## Contributing

Pull requests are welcome, but consider asking for a feature or bug fix first through the issue tracker. When contributing code, please squash sloppy commits aggressively and follow [Tim Pope's guidelines][tim_pope_guidelines] for commit messages.

There are a number of ways to get started after cloning the repository.

To set up your environment:
```
script/bootstrap
```

To run the test suite:
```
script/test
```

To open a console with the gem loaded:
```
script/console
```

[tim_pope_guidelines]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html


## Copyright
Copyright (c) 2013 Craig Little. See [LICENSE][license] for details.

[license]: https://github.com/craiglittle/hello_sign/blob/master/LICENSE.md
