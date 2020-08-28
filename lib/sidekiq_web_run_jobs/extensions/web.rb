require 'sidekiq/web' unless defined?(Sidekiq::Web)

Sidekiq::Web.register(SidekiqWebRunJobs::Web)
Sidekiq::Web.tabs['job_runner'] = 'job-runner'
Sidekiq::Web.locales << File.expand_path(File.dirname(__FILE__) + '/../../../web/locales')
