require 'sidekiq_web_run_jobs/job_runner'

Sidekiq::JobRunner = SidekiqWebRunJobs::JobRunner
