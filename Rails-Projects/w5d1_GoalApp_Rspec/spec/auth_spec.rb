require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit('users/new')
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    before(:each) do
      visit("users/new")
      fill_in 'Username', with: "Ryan"
      fill_in 'Password', with: "chocolate"
      click_on "Sign Up"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content("Ryan")
    end
  end
end

feature "logging in" do
  it "shows username on the homepage after logging in" do
    sign_in_user
    expect(page).to have_content("Ryan")
  end
end

feature "logging out" do
  before(:each) do
    sign_in_user
    click_on "Sign Out"
    visit("/goals")
  end

  it "begins with logged out state" do
    expect(page).to have_content("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    expect(page).to_not have_content("Ryan")
  end

end
