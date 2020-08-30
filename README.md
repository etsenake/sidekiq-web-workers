# SidekiqWebRunJobs

`sidekiq_web_run_jobs` is an extension to Sidekiq that allows you to run jobs from your sidekiq web ui


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq_web_run_jobs'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sidekiq_web_run_jobs

## Usage

Once you've installed the gem to add workers that will show up in the web workers section, you'll need to make a file called `sidekiq_web_jobs.yml` in your application root config folders.
If your application is not rails standard or simply wish to change the default location the gem searches for the `sidekiq_web_jobs.yml` you can do so as follows in your `sidekiq.rb` initializer.

`Sidekiq::WebWorkers.config_root = <folder you want>`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/etsenake/sidekiq_web_run_jobs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/etsenake/sidekiq_web_run_jobs/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SidekiqWebRunJobs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/etsenake/sidekiq_web_run_jobs/blob/master/CODE_OF_CONDUCT.md).
