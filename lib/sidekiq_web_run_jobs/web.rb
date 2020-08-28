require 'sidekiq_web_run_jobs'
require_relative 'job_presenter'
require_relative 'extensions/web'

module SidekiqWebRunJobs
  # Hook into *Sidekiq::Web* Sinatra app which adds a new '/recurring-jobs' page

  module Web
    VIEW_PATH = File.expand_path('../../../web/views', __FILE__)

    def self.registered(app)
      app.get '/run-jobs' do
        # load yml file
        # run through job presenter to create @presented_jobs for the FE
      end

      app.get '/run_jobs/:name/new' do
        # run name through job presenter to create @presented_job
      end

      app.post '/run_jobs/:name/create' do
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

