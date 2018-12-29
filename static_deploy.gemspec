lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'static_deploy/version'

Gem::Specification.new do |spec|
  spec.name          = "static_deploy"
  spec.version       = StaticDeploy::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["pmurach@gmail.com"]
  spec.description   = %q{Automated deployment to GitHub pages}
  spec.summary       = %q{Provides rake tasks for publishing your static site to github pages to any remote repository}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['{lib,spec}/**/*.rb', 'static_deploy.gemspec']
  spec.files        += Dir['README.md', 'LICENSE.txt', 'Rakefile']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency 'tty-prompt', '~> 0.18'
  spec.add_runtime_dependency 'rake'

  spec.add_development_dependency 'bundler', '>= 1.5.0', '< 2.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
end
