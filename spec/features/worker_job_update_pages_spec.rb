require 'rails_helper'

describe 'the claim job path' do
  it "allow the worker to claim job posts after loging in.", js: true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    login_as(worker, :scope => :worker)
    visit job_path(job)
    click_link "click here to claim it now"
    expect(page).to have_content "Send all inquires to :build1t@gmail.com"
  end
  it "wont allow users to claim a job" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    job = FactoryGirl.create(:job)
      visit job_path(job)
    click_link "click here to claim it now"
    expect(page).to have_content "You must have a worker account to claim a job. Register for one using the link in the navbar above."
  end

  it "will allow to mark a job as active", js:true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    login_as(worker, :scope => :worker)
    visit job_path(job)
    click_link "click here to claim it now"
    click_link 'Update the State of the Job'
    check('Actively being worked on:')
    click_button 'Update Job'
    expect(page).to have_content "Job is currently underway"
  end
  it "will allow to mark a job as completed", js:true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    login_as(worker, :scope => :worker)
    visit job_path(job)
    click_link "click here to claim it now"
    click_link 'Update the State of the Job'
    check('Completed?')
    click_button 'Update Job'
    expect(page).to have_content "Job is completed!"
  end

end
