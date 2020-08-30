module SidekiqWebRunJobs
  class JobRunner
    attr_reader :worker_name

    def self.execute!(*args)
      new(*args).execute!
    end
    
    def initialize(worker_name:, worker_parameters:, perform_in: nil)
      @worker_name = worker_name
      @worker_parameters = worker_parameters
      @perform_in = perform_in
    end

    def execute!
      enqueue_worker
    end

    private def enqueue_worker
      args = arguments_array
      if @perform_in.present?
        worker.perform_in(@perform_in.to_i.minutes, *args)
      else
        worker.perform_async(*args)
      end
    end
    private def arguments_array
      # {param_name: param_value,....}
      @worker_parameters.values
    end

    private def worker
      worker_name.constantize
    end
  end
end
