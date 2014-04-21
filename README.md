# HelloSign

A Ruby interface to the HelloSign API

[![Gem Version](https://badge.fury.io/rb/hello_sign.png)][gem_version]
[![Build Status](https://travis-ci.org/craiglittle/hello_sign.png?branch=master)][build_status]
[![Dependency Status](https://gemnasium.com/craiglittle/hello_sign.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/craiglittle/hello_sign.png)][code_climate]

[gem_version]: http://badge.fury.io/rb/hello_sign
[build_status]: https://travis-ci.org/craiglittle/hello_sign
[gemnasium]: https://gemnasium.com/craiglittle/hello_sign
[code_climate]: https://codeclimate.com/github/craiglittle/hello_sign

## Installation
```ruby
gem install hello_sign
```

## Getting started

Here's all it takes to send a signature request:

```ruby
HelloSign.configure do |hs|
  hs.email_address = 'user@example.com'
  hs.password      = 'password'
end

HelloSign.signature_request.deliver do |request|
  request.title   = 'Our contract'
  request.subject = 'Here is the contract for you to sign!'
  request.message = 'You should definitely sign this.'
  request.signers = [
    {name: 'Jack', email_address: 'jack@hill.com'},
    {name: 'Jill', email_address: 'jill@hill.com'}
  ]
  request.files   = [{filename: 'path/to/contract.pdf'}]
end
```

For a comprehensive guide to supported functionality, check out the [wiki][wiki].

[wiki]: https://github.com/craiglittle/hello_sign/wiki

## Supported Ruby interpreters

This gem officially supports and is tested against the following Ruby interpreters:

* MRI 1.9.2
* MRI 1.9.3
* MRI 2.0.0
* MRI 2.1.0
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
Copyright (c) 2013-2014 Craig Little. See [LICENSE][license] for details.

[license]: https://github.com/craiglittle/hello_sign/blob/master/LICENSE.md
