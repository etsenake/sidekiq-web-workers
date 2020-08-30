RSpec.describe SidekiqWebRunJobs do
  let(:current_path) { `pwd`.strip }
  it "has a version number" do
    expect(SidekiqWebRunJobs::VERSION).to match(/\d{1}.\d{1}.\d{1}/)
  end

  after { SidekiqWebRunJobs.instance_variable_set(:@config, nil) }

  describe "#config_path" do
    it "returns nil if config_root is nil" do
      SidekiqWebRunJobs.instance_variable_set(:@config_root, nil)
      expect(SidekiqWebRunJobs.config_path).to eq nil
    end

    it "returns full path if config root is set" do
      SidekiqWebRunJobs.config_root = current_path
      expect(SidekiqWebRunJobs.config_path)
        .to eq(Pathname.new("#{current_path}/config/sidekiq_web_jobs.yml"))
    end
  end

  describe "#load_jobs" do
    context "when file does not exist" do
      before { SidekiqWebRunJobs.config_root = current_path }

      it "warns about the error" do
        expect(Sidekiq.logger).to receive(:warn).with("YAML configuration file couldn't be found")
        subject.load_jobs
      end
    end
    context "when file exists but cannot be parsed" do
      before { SidekiqWebRunJobs.config_root = current_path }

      it "warns about the error" do
        allow(YAML).to receive(:load_file)
          .and_raise Psych::SyntaxError.new(1,2,3,4,5,6)
        expect(Sidekiq.logger).to receive(:warn)
          .with("YAML configuration file contains invalid syntax")
        subject.load_jobs
      end
    end

    it "sets config to empty array if config_root is nil" do
      SidekiqWebRunJobs.instance_variable_set(:@config_root, nil)
      subject.load_jobs
      expect(SidekiqWebRunJobs.instance_variable_get(:@config)).to eq []
    end
  end

  describe "#config_root" do
    it "sets the root to string given as a pathname" do
      SidekiqWebRunJobs.config_root = "hi"
      expect(SidekiqWebRunJobs.instance_variable_get(:@config_root)).to eq Pathname.new("hi")
    end

    it "sets the root to pathname given as a pathname" do
      path = Pathname.new("hi")
      SidekiqWebRunJobs.config_root = path
      expect(SidekiqWebRunJobs.instance_variable_get(:@config_root)).to eq path
    end
  end

  describe "#search_jobs" do
    let(:job_list) { ["Hello::TestWorkerWithDescription"] }
    before { allow(SidekiqWebRunJobs).to receive(:jobs).and_return(job_list)}
    it "returns the whole list if search_text is empty" do
      expect(SidekiqWebRunJobs.search_jobs("")).to eq job_list
    end

    it "searches using the Job presenter's include" do
      presenter_double = double(empty?: false)
      search_text = "hi"
      expect(JobPresenter).to receive(:new)
        .with(job_list.first)
        .and_return(presenter_double)
      expect(presenter_double).to receive(:include?).with(search_text)
      expect(SidekiqWebRunJobs.search_jobs(search_text)).to eq []
    end
  end

  describe "#jobs" do
    it "calls load_jobs if config isn't set" do
      expect(SidekiqWebRunJobs).to receive(:load_jobs).once
      SidekiqWebRunJobs.jobs
    end

    it "does not call load_jobs if config is set" do
      SidekiqWebRunJobs.load_jobs
      expect(SidekiqWebRunJobs).not_to receive(:load_jobs)
      SidekiqWebRunJobs.jobs
    end
  end
end
