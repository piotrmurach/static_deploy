# StaticDeploy

[![Gem Version](https://badge.fury.io/rb/static_deploy.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/static_deploy.svg?branch=master)][travis]

[gem]: http://badge.fury.io/rb/static_deploy
[travis]: http://travis-ci.org/piotrmurach/static_deploy

> Rake tasks to ease publishing a static website via git to a remote repository (e.g. GitHub pages).

## Installation

Add this line to your application's Gemfile:

    gem 'static_deploy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install static_deploy

## Usage

In `Rakefile` add the following:

```ruby
require 'static_deploy'

ENV['GENERATOR'] = 'jekyll'  # => static website generator executable
ENV['COMMAND']   = 'build'   # => command for building a project, defaults to 'build'
```

When deploying inside the current repository, git defaults are used to get username and repository name:

```ruby
bundle exec rake site:publish
```

Otherwise, to publish to remote branch in the different repository do:

```ruby
bundle exec rake site:publish["username/repository"]
```

As a convenience you may want to add the following rake task to your `Rakefile`:

```ruby
desc 'publish this site'
task :publish do
  Rake::Task['site:publish'].invoke("username/repository")
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Code of Conduct

Everyone interacting in the StaticDeploy project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/static_deploy/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2013 Piotr Murach. See LICENSE for further details.
