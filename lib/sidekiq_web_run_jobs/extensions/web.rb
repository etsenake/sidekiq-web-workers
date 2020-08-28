require 'sidekiq/web' unless defined?(Sidekiq::Web)
require 'sidekiq_web_run_jobs/web'

Sidekiq::Web.register(SidekiqWebRunJobs::Web)
Sidekiq::Web.tabs['Job Runner'] = '/run_jobs'
Sidekiq::Web.locales << File.expand_path(File.dirname(__FILE__) + '/../../../web/locales')
