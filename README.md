# StaticDeploy

Provides rake tasks for publishing your static website via git to any remote repository(GitHub pages).

## Installation

Add this line to your application's Gemfile:

    gem 'static_deploy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install static_deploy

## Usage

In your Rakefile add the following

```ruby
  require 'static_deploy'

  ENV['GENERATOR'] = 'jekyll' # => static website generator executable
  ENV['COMMAND']   = 'build'  # => command for building a project, defaults to 'build'
```

Then to publish to remote branch do

```ruby
  bundle exec rake publish["username/repository"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2013 Piotr Murach. See LICENSE for further details.
