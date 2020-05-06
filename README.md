# Lolcommits Mumble

[![Gem](https://img.shields.io/gem/v/lolcommits-mumble.svg?style=flat)](http://rubygems.org/gems/lolcommits-mumble)
[![Travis](https://img.shields.io/travis/com/lolcommits/lolcommits-mumble/master.svg?style=flat)](https://travis-ci.com/lolcommits/lolcommits-mumble)
[![Depfu](https://img.shields.io/depfu/lolcommits/lolcommits-mumble.svg?style=flat)](https://depfu.com/github/lolcommits/lolcommits-mumble)
[![Maintainability](https://api.codeclimate.com/v1/badges/a866b41555abbda9dec0/maintainability)](https://codeclimate.com/github/lolcommits/lolcommits-mumble/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a866b41555abbda9dec0/test_coverage)](https://codeclimate.com/github/lolcommits/lolcommits-mumble/test_coverage)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your
webcam every time you git commit code, and archives a lolcat style image
with it. Git blame has never been so much fun!

This plugin automatically posts your lolcommits to one (or more)
[Mumble](https://www.mumble.com/) channels.

The Mumble post will contain the git commit message and repo name. The
SHA is used as the uploaded file name. Posting will be retried (once)
should any error occur.

## Requirements

* Ruby >= 2.3
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

Follow the [install guide](https://github.com/lolcommits/lolcommits#installation) for
lolcommits first. Then run the following:

    $ gem install lolcommits-mumble

## Configuration

Next configure and enable with:

    $ lolcommits --config -p mumble
    # set enabled to `true`
    # enter your URL, server and channel ID (see below)

That's it! Every lolcommit will now be posted to these Mumble channels.
To disable simply reconfigure with `enabled: false`.

### Murmur server API

This plugin uses Mumble [murmur-rest](https://github.com/alfg/murmur-rest) for communication. 
TODO: explain commands to get.

## Development

Check out this repo and run `bin/setup`, this will install dependencies
and generate docs. Run `bundle exec rake` to run all tests and generate
a coverage report.

You can also run `bin/console` for an interactive prompt that will allow
you to experiment with the gem code.

## Tests

MiniTest is used for testing. Run the test suite with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, please raise a new
[issue](https://github.com/lolcommits/lolcommits-mumble/issues). Take a
moment to check it hasn't been raised in the past (and possibly closed).

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-mumble/issues) and [pull requests](https://github.com/lolcommits/lolcommits-mumble/pulls)
are welcome on GitHub.

When submitting pull requests, remember to add tests covering any new
behaviour, and ensure all tests are passing on [Travis
CI](https://travis-ci.com/lolcommits/lolcommits-mumble). Read the
[contributing
guidelines](https://github.com/lolcommits/lolcommits-mumble/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for
collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.
See
[here](https://github.com/lolcommits/lolcommits-mumble/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [Travis CI](https://travis-ci.com/lolcommits/lolcommits-mumble)
* [Test Coverage](https://codeclimate.com/github/lolcommits/lolcommits-mumble/test_coverage)
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-mumble)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-mumble)
* [Issues](http://github.com/lolcommits/lolcommits-mumble/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-mumble/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-mumble)
* [GitHub](https://github.com/lolcommits/lolcommits-mumble)
