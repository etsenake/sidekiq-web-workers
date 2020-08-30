require "bundler/setup"
require "sidekiq_web_run_jobs"
require 'sidekiq'
require "sidekiq/testing"
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

module Hello
  class TestWorkerWithDescription

    # stubbing these methods because I don't wanna require redis just for tests
    # and sidekiq's perform_async and perform_in doesn't work without redis
    def self.perform_async(*)
      "job_id"
    end

    def self.perform_in(*)
      "job_id"
    end

    def perform(test_param, optional_param = 1)

    end

    def self.description
      "This is a test description"
    end
  end
end
