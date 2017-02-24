require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should validate_presence_of :title}
  it { should validate_presence_of :description}

  describe ".mark_active method" do
    it "will return true if the job is considered active" do
      test_worker = FactoryGirl.create(:worker)
      test_job = FactoryGirl.create(:job, :worker_id => 1)
      test_job.mark_active(test_worker)
      expect(test_job.is_active).to eq true
      end
    it "will alert the user of the inputed worker does not have access to the job." do
    test_worker = FactoryGirl.create(:worker)
    test_job = FactoryGirl.create(:job, :worker_id => 2)
    expect(test_job.mark_active(test_worker)).to eq "Current worker has no claim to this job."
    end
  end
end
