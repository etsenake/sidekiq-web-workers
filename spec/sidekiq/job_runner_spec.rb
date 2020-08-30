RSpec.describe Sidekiq::WebWorkers do
  it "is an alias for SidekiqWebWorkers" do
    expect(Sidekiq::WebWorkers).to eq(SidekiqWebWorkers)
  end
end
