require 'rails_helper'

describe 'the add job, user path' do
  it "allow the user to create job posts after loging in." do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    click_link "Add Your Job"
    fill_in "Title", :with => "Broken Door"
    fill_in "Description", :with => "Its absolutely unhinged!"
    click_button "Create Job"
    expect(page).to have_content "Broken Door"

  end
end
