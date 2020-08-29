class JobPresenter
  attr_reader :worker_name

  def initialize(job_name)
    @worker_name = job_name
  end

  def description
    job_constantized.respond_to?(:description) ? job_constantized.description : ""
  end

  def method_arguments
    job_constantized.new.method(:perform).parameters
    #[[:opt, :param_name], [:req, :param_name]] empty if no params
    # for named parameters this can be [[:key, :param_name], [:keyreq, :param_name]]
    # key means optional keyreq means required but sidekiq does not s
    # sidekiq doesn't support named args tho https://github.com/mperham/sidekiq/issues/2372
  end

  def job_constantized
    @worker_name.constantize
  rescue
    nil
  end

  def empty?
    job_constantized.blank?
  end

  def escaped_name
    CGI.escape worker_name
  end

  def include?(text)
    return false unless job_constantized
    downcased_text = text.downcase
    worker_name.downcase.include?(downcased_text) ||
      description.downcase.include?(downcased_text)
  end
end
