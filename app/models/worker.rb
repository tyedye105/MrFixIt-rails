class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :jobs
  def mark_active(job)
    job_to_activate = self.jobs.find(job.id)
    if self.id === job_to_activate.worker_id
      job_to_activate.is_active = true
    else
      return false
    end
    return job_to_activate
  end
end
