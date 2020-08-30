require 'sidekiq_web_run_jobs/job_runner'

Sidekiq::WebWorkers = SidekiqWebRunJobs
