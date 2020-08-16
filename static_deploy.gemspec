# frozen_string_literal: true

require_relative "lib/static_deploy/version"

Gem::Specification.new do |spec|
  spec.name          = "static_deploy"
  spec.version       = StaticDeploy::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.description   = %q{Automated deployment to GitHub pages}
  spec.summary       = %q{Provides rake tasks for publishing your static site to github pages to any remote repository}
  spec.homepage      = "https://github.com/piotrmurach/static_deploy"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]
  spec.files        += Dir["README.md", "LICENSE.txt", "Rakefile"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_runtime_dependency "tty-prompt", "~> 0.22"
  spec.add_runtime_dependency "rake"

  spec.add_development_dependency "rspec", ">= 3.0"
end
