class Job < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true

  def mark_active(worker)
    if self.worker_id === worker.id
      self.is_active = true
    else
      return "Current worker has no claim to this job."
    end
  end

end
