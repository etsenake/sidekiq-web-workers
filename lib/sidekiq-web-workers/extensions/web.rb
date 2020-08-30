require 'sidekiq/web' unless defined?(Sidekiq::Web)
require 'sidekiq-web-workers/web'

Sidekiq::Web.register(SidekiqWebWorkers::Web)
Sidekiq::Web.tabs['Web Workers'] = 'run_jobs'
Sidekiq::Web.locales << File.expand_path(File.dirname(__FILE__) + '/../../../web/locales')
