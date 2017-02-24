class JobsController < ApplicationController

  def index
    @jobs = Job.all
  end

  def new
   @job = Job.new
   render :new
  end

  def show
    @worker = Worker.all
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = "You have posted a job!"
      redirect_to jobs_path
    else
      redirect_to new_job_path
      flash[:alert] = "text fields can't be blank."
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if current_worker
      if @job.pending === true
        if @job.update(job_params)
          flash[:notice] = "You have updated the Job"
          respond_to do |format|
            format.html {redirect_to job_path(@job)}
          end
        end
      else
        if @job.update(pending: true, worker_id: current_worker.id)
        flash[:notice] = "You've successfully claimed this job."
        respond_to do |format|
          format.html {redirect_to job_path(@job)}
        end
        else
          render :show
          flash[:notice] = "Something went wrong!"
        end
      end
    else
      # We need to streamline this process better in the future! - Mr. Fix-It.
      flash[:notice] = 'You must have a worker account to claim a job. Register for one using the link in the navbar above.'
      redirect_to job_path(@job)
    end
  end

private

  def job_params
    params.require(:job).permit(:title, :description, :is_active, :completed, :is_pending )
  end

end
