require 'sidekiq'
require_relative '../job_runner'

Sidekiq.extend SidekiqWebRunJobs::JobRunner
