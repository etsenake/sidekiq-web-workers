require 'sidekiq'
require 'rails'
require 'sidekiq/job_runner'
require 'sidekiq-web-workers/job_presenter'
require 'sidekiq-web-workers/version'
require 'sidekiq-web-workers/job_runner'
require 'sidekiq-web-workers/web'
require 'sidekiq-web-workers/extensions/web'

module SidekiqWebWorkers
  def self.jobs
    @jobs ||= load_jobs.uniq
  end

  def self.config_root=(path = Rails.root)
    @config_root = path if path.is_a? Pathname
    @config_root = Pathname.new(path)
  end

  def self.load_jobs
    if config_path.present?
      YAML.load_file(config_path)
    else
      []
    end
  rescue Errno::ENOENT
    Sidekiq.logger.warn("YAML configuration file couldn't be found")
    []
  rescue Psych::SyntaxError
    Sidekiq.logger.warn("YAML configuration file contains invalid syntax")
    []
  end

  def self.config_path
    @config_root&.join("config", "sidekiq_web_jobs.yml")
  end

  def self.search_jobs(search_text)
    job_names = SidekiqWebWorkers.jobs
    return job_names unless search_text.present?

    job_names.map{ |job_name| JobPresenter.new(job_name) }
      .delete_if(&:empty?)
      .find_all { |job| job.include?(search_text) }
  end
end

