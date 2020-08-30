RSpec.describe SidekiqWebRunJobs::JobRunner do
  around(:each) do |example|
    Sidekiq::Testing.inline! { example.run }
  end

  context 'when condition' do
    it 'succeeds' do
      pending 'Not implemented'
    end
  end
end
