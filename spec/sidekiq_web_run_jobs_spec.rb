RSpec.describe SidekiqWebRunJobs do
  it "has a version number" do
    expect(SidekiqWebRunJobs::VERSION).to match(/\d{1}.\d{1}.\d{1}/)
  end
end
