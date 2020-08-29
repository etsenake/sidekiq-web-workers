require 'sidekiq'
require 'rails'
require 'sidekiq/job_runner'
require 'sidekiq_web_run_jobs/job_presenter'
require 'sidekiq_web_run_jobs/version'
require 'sidekiq_web_run_jobs/job_runner'
require 'sidekiq_web_run_jobs/web'
require 'sidekiq_web_run_jobs/extensions/web'

module SidekiqWebRunJobs
  def self.jobs
    load_jobs
  end

  def self.config_root=(path = Rails.root)
    @config_root = path
  end

  def self.load_jobs
    if config_path.present?
      @config = YAML.load_file(config_path)
    else
      @config = []
    end
  rescue Errno::ENOENT
    Sidekiq.logger.warn("YAML configuration file couldn't be found")
  rescue Psych::SyntaxError
    Sidekiq.logger.warn("YAML configuration file contains invalid syntax.")
  ensure
    @config = []
  end

  def self.config_path
    @config_root&.join("config", "sidekiq_web_jobs.yml")
  end

  def self.search_jobs(search_text)
    job_names = SidekiqWebRunJobs.jobs
    return job_names unless search_text.present?

    job_names.map{ |job_name| JobPresenter.new(job_name) }
      .delete_if(&:empty?)
      .find_all { |job| job.include?(search_text) }
  end
end

