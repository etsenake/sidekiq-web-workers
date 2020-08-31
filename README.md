# SidekiqWebWorkers

`sidekiq-web-workers` is an extension to Sidekiq that allows you to run jobs from your sidekiq web ui

[![Gem Version](https://badge.fury.io/rb/sidekiq-web-workers.svg)](https://badge.fury.io/rb/sidekiq-web-workers)
<a href="https://codeclimate.com/github/etsenake/sidekiq-web-workers/maintainability"><img src="https://api.codeclimate.com/v1/badges/4e80e0acd08398d0df0d/maintainability" /></a>
[![Build Status](https://travis-ci.com/etsenake/sidekiq-web-workers.svg?branch=master)](https://travis-ci.com/etsenake/sidekiq-web-workers)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-web-workers'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sidekiq-web-workers

## Usage

Once you've installed the gem to add workers that will show up in the web workers section, you'll need to make a file called `sidekiq_web_jobs.yml` in your application root config folders.
If your application is not rails standard or simply wish to change the default location the gem searches for the `sidekiq_web_jobs.yml` you can do so as follows in your `sidekiq.rb` initializer.

The yml file should follow yml list syntax ie `- WorkerName`

`Sidekiq::WebWorkers.config_root = <folder you want>`

Set a description in your worker class by declaring a class method as follows: 
```ruby
class WorkerClass
  def self.description
    "this is my description"
  end
end    
``` 

![Sidekiq Web integration](https://media.giphy.com/media/ehCx2H36mzwlApmiln/giphy.gif)

## Caveats
Because the parameters are entered through the web ui every param is a String, account for this in your code accordingly. If using the param to query activerecord conversion from string is not necessary as active record does that for you.
Complex data structures like hashes and `perform` methods with named parameters are not supported. Note that named parameters are not supported by sidekiq itself.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/etsenake/sidekiq-web-workers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/etsenake/sidekiq-web-workers/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SidekiqWebWorkers project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/etsenake/sidekiq-web-workers/blob/master/CODE_OF_CONDUCT.md).
