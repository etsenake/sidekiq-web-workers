RSpec.describe SidekiqWebRunJobs::JobRunner do
  it "throws an error if worker_name is not a valid class" do
    arguments = {
      worker_name: "RandomWorkerClass",
      worker_parameters: {},
      perform_in: 5
    }
    expect { described_class.execute!(arguments) }.to(
      raise_error(NameError,
        /uninitialized constant RandomWorkerClass/
      )
    )
  end

  it "enqueues with perform_async if perform_in is nil" do
    arguments = {
      worker_name: "Hello::TestWorkerWithDescription",
      worker_parameters: { test_param: "1", optional_param: "1" },
      perform_in: ""
    }
    expect(Hello::TestWorkerWithDescription).to receive(:perform_async)
      .with("1", "1")
    described_class.execute!(arguments)
  end

  it "enqueues with perform_in when value is passed" do
    arguments = {
      worker_name: "Hello::TestWorkerWithDescription",
      worker_parameters: { test_param: "1", optional_param: "1" },
      perform_in: "5"
    }
    expect(Hello::TestWorkerWithDescription).to receive(:perform_in)
      .with(5.minutes,"1", "1")
    described_class.execute!(arguments)
  end

  it "converts empty strings to nil to preserve optional parameters default value" do
    arguments = {
      worker_name: "Hello::TestWorkerWithDescription",
      worker_parameters: { test_param: "1", optional_param: "" },
      perform_in: ""
    }
    expect(Hello::TestWorkerWithDescription).to receive(:perform_async)
      .with("1", nil)
    described_class.execute!(arguments)
  end
end
