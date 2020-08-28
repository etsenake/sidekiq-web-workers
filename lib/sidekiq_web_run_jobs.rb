require 'sidekiq'
require 'rails'
require 'sidekiq/job_runner'
require 'sidekiq_web_run_jobs/job_presenter'
require 'sidekiq_web_run_jobs/version'
require 'sidekiq_web_run_jobs/job_runner'
require 'sidekiq_web_run_jobs/web'
require 'sidekiq_web_run_jobs/extensions/web'
require 'sidekiq_web_run_jobs/extensions/job_runner'

module SidekiqWebRunJobs
  def self.config
    configure
  end

  def self.config_root=(path = Rails.root)
    @config_root = path
  end

  def self.configure
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
end

