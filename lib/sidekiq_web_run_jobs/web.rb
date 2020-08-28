require_relative 'job_runner'
require_relative 'job_presenter'
require 'sidekiq/web' unless defined?(Sidekiq::Web)

module SidekiqWebRunJobs
  module Web
    VIEW_PATH = File.expand_path('../../../web/views', __FILE__)

    def self.registered(app)
      app.get '/run_jobs' do
        job_names = SidekiqWebRunJobs.config
        @count = (params["count"] || 25).to_i
        (@current_page, @total_size, @presented_jobs) = page("run_jobs", params["page"], @count)
        @presented_jobs = job_names.map{ |job_name| JobPresenter.new(job_name) }.delete_if(&:empty?)
        erb File.read(File.join(VIEW_PATH, 'web_jobs.erb'))
      end

      app.get '/run_jobs/:name/new' do
        worker_name = CGI.unescape(params[:name])
        @presented_job = JobPresenter.new(worker_name)
        erb File.read(File.join(VIEW_PATH, 'new_web_jobs.erb'))
      end

      app.post '/run_jobs/:name/create' do
        worker_name = CGI.unescape(params[:name])
        params.inspect
        if params[:perform_in].present?
          JobRunner.execute!(
            perform_in: params[:perform_in],
            workers_parameters: params[:workers_parameters],
            worker_name: worker_name
          )
        else
        end

        # expecting {
        # 	perform_in: <minutes>| nil,
        # 	worker_parameters: {}
        # }
        #if perform_in is nil
        # 			- use `perform_async(build_arg_array(params[:workers_parameters])`
        # 		- if perform_in is present
        # 			- use `perform_in(params[:perform_in].to_i, build_arg_array(params[:workers_parameters])`
        # 		- redirects to /admin/sidekiq/busy?poll=true if you’ve queued it to run now
        # 		- redirect to /admin/sidekiq/scheduled if you’ve queued it to run in a particular time
        #
      end
    end
  end
end

