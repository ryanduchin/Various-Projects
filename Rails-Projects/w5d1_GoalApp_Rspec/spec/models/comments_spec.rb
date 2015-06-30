require 'spec_helper'
require 'rails_helper'

feature 'the commenting on users' do
  before(:each) do
    sign_in_user
    click_on "Sign Out"
    sign_in_user("Aaron")
    visit '/users/1'
    fill_in "Add Comment", with: "This dude is the coolest partner ever!!!"
    click_on "Submit Comment"
  end

  it 'can comment on users' do
    visit '/users/1'
    expect(page).to have_content("Ryan")
    expect(page).to have_content("This dude is the coolest partner ever!!!")
  end
end

feature 'the commenting on goals' do
  before(:each) do
    sign_in_user
    submit_goal
    click_on "Sign Out"
    sign_in_user("Aaron")
    visit '/goals/1'
    fill_in "Add Comment", with: "Augustus Gloop! Augustus Gloop! The great big greedy nincompoop!"
    click_on "Submit Comment"
  end

  it 'can comment on users' do
    visit '/goals/1'
    expect(page).to have_content("Chocolate")
    expect(page).to have_content("Augustus Gloop! Augustus Gloop! The great big greedy nincompoop!")
  end
end
