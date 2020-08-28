require_relative 'lib/sidekiq_web_run_jobs/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq_web_run_jobs"
  spec.version       = SidekiqWebRunJobs::VERSION
  spec.authors       = ["Josh Etsenake"]
  spec.email         = ["etsenake@gmail.com"]

  spec.summary       = %q{Lightweight Job runner from sidekiq web ui}
  spec.homepage      = "https://github.com/etsenake/sidekiq_web_run_jobs"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = 'https://rubygems.org'

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'sidekiq', '>= 3'
  spec.add_dependency 'rails', '>= 5.0'
end