require 'json'
module SidekiqWebRunJobs
  module JobRunner
    attr_reader :worker_name

    def execute!(worker_name:, worker_parameters:, perform_in: nil)
      @worker_name = worker_name
      @worker_parameters = worker_parameters
      @perform_in = perform_in
      enqueue_worker
    end

    private def enqueue_worker
      args = build_arg_array
      if @perform_in.present?
        worker.perform_in(@perform_in.minutes, *args)
      else
        worker.perform_async(*args)
      end
    end
    private def build_arg_array
      # {param_name: param_value,....}
      @worker_parameters.values
    end

    private def worker
      worker_name.constantize
    end
  end
end
