RSpec.describe JobPresenter do
  subject { described_class.new("Hello::TestWorkerWithDescription") }

  describe "#description" do
    it "returns description if job class responds to description" do
      expect(subject.description).to eq("This is a test description")
    end

    it "returns empty string if job class does not respond to description" do
      class TestWorkerNoDescription
      end
      expect(described_class.new("TestWorkerNoDescription").description).to eq ""
    end

    it "returns empty description if job class is an uninitialized constant" do
      expect(described_class.new("RandomWorkerClass").description).to eq ""
    end
  end

  describe "#method_arguments" do
    it "returns an empty array if job class is an uninitialized constant" do
      expect(described_class.new("RandomWorkerClass").method_arguments).to eq []
    end

    it "returns the correct parameters" do
      expect(subject.method_arguments).to eq [[:req, :test_param], [:opt, :optional_param]]
    end

    it "throws an error if job class does not have a perform method" do
      class TestWorkerWithNoPerform
      end
      expect{described_class.new("TestWorkerWithNoPerform").method_arguments}.to(
        raise_error(NameError,
          "undefined method `perform' for class `TestWorkerWithNoPerform'"
        )
      )
    end
  end

  describe "#job_constantized" do
    it "returns the job class if it is a valid class" do
      expect(subject.job_constantized).to eq Hello::TestWorkerWithDescription
    end

    it "returns nil if the job class is an uninitialized constant" do
      expect(described_class.new("RandomWorkerClass").description).to eq ""
    end
  end

  describe "#empty?" do
    it "returns false if the job class is a found class" do
      expect(subject.empty?).to eq false
    end

    it "returns true if the job class is an uninitialized constant" do
      expect(described_class.new("RandomWorkerClass").empty?).to eq true
    end
  end

  describe "#escaped_name" do
    it "escapes the worker name" do
      expect(subject.escaped_name).to eq "Hello%3A%3ATestWorkerWithDescription"
    end
  end

  describe "#include?" do
    let(:search_with) { "Test" }
    it "returns false if worker name is not a found class" do
      expect(described_class.new("RandomWorkerClass").include?(search_with)).to be false
    end

    it "returns true if text is found in worker name" do
      expect(subject.include?(search_with)).to be true
    end

    it "returns true if text is found in worker description" do
      expect(subject.include?("description")).to be true
    end
    it "is case insensitive" do
      expect(subject.include?(search_with.downcase)).to be true
    end
  end
end
