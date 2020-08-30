require_relative 'job_runner'
require_relative 'job_presenter'
require 'sidekiq/web' unless defined?(Sidekiq::Web)

module SidekiqWebWorkers
  module Web
    VIEW_PATH = File.expand_path('../../../web/views', __FILE__)

    def self.registered(app)
      app.get '/run_jobs' do
        job_names = SidekiqWebWorkers.jobs
        @count = (params["count"] || 25).to_i

        @presented_jobs = job_names.map{ |job_name| JobPresenter.new(job_name) }.delete_if(&:empty?)
        @total_size = @presented_jobs.size
        @current_page = params["page"].to_i > 0 ? params["page"].to_i : 1
        start_idx = @count * (@current_page - 1)
        end_idx = @count * @current_page
        @presented_jobs = @presented_jobs[start_idx..end_idx]
        erb File.read(File.join(VIEW_PATH, 'web_jobs.erb'))
      end

      app.get '/run_jobs/:name/new' do
        worker_name = CGI.unescape(params[:name])
        @presented_job = JobPresenter.new(worker_name)
        erb File.read(File.join(VIEW_PATH, 'new_web_jobs.erb'))
      end

      app.post '/run_jobs/:name/create' do
        @worker_name = CGI.unescape(params[:name])
        @job_id = JobRunner.execute!(
          perform_in: params[:perform_in],
          worker_parameters: params[:worker_parameters],
          worker_name: @worker_name
          )
        erb File.read(File.join(VIEW_PATH, 'create_web_jobs.erb'))
      end

      app.post '/filter/run_jobs' do
        search_with = params[:substr]
        return redirect "#{root_path}run_jobs" unless search_with.present?
        @count = (params["count"] || 25).to_i
        @presented_jobs = SidekiqWebWorkers.search_jobs(search_with)
        @total_size = @presented_jobs.size

        @current_page = params["page"].to_i > 0 ? params["page"].to_i : 1
        start_idx = @count * (@current_page - 1)
        end_idx = @count * @current_page
        @presented_jobs = @presented_jobs[start_idx..end_idx]
        erb File.read(File.join(VIEW_PATH, 'web_jobs.erb'))
      end
    end
  end
end

