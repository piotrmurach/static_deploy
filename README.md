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

In your `Rakefile` add the following

```ruby
require 'static_deploy'

ENV['GENERATOR'] = 'jekyll'  # => static website generator executable
ENV['COMMAND']   = 'build'   # => command for building a project, defaults to 'build'
```

If you are deploying inside current repository, git defaults are used to get username and repository name

```ruby
bundle exec rake site:publish
```

Otherwise, to publish to remote branch on different repository do

```ruby
bundle exec rake site:publish["username/repository"]
```

As a convenience you may wish to add the following rake task to your `Rakefile`

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

## Copyright

Copyright (c) 2013-2016 Piotr Murach. See LICENSE for further details.
