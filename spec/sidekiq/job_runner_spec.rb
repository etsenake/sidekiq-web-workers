RSpec.describe Sidekiq::WebWorkers do
  it "is an alias for SidekiqWebRunJobs" do
    expect(Sidekiq::WebWorkers).to eq(SidekiqWebRunJobs)
  end
end
