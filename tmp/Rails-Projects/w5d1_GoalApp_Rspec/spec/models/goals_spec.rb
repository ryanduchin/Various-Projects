require 'spec_helper'
require 'rails_helper'

feature "the goal submitting process" do
  before(:each) do
    sign_in_user
  end

  it "has a new goal page" do
    visit "goals/new"
    expect(page).to have_content("Create New Goal")
  end

  feature "submitting a goal" do
    before(:each) do
      visit "goals/new"
      fill_in "Title", with: "Chocolate"
      fill_in "Body", with: "Need more chocolate"
      click_on "Submit Goal"
    end

    it "redirects to goal show page" do
      expect(page).to have_content("Chocolate")
      expect(page).to have_content("Need more chocolate")
    end

    it "has a link to all goals" do
      click_on "All Goals"
      expect(page).to have_content("All Goals")
    end
  end
end

feature "updating goals" do
  before(:each) do
    sign_in_user
    submit_goal
    click_on "Edit Goal"
  end

  it "has an edit page" do
    expect(page).to have_content("Edit Goal")
  end

  feature "editing a goal" do
    before(:each) do
      fill_in "Title", with: "Chocolate"
      fill_in "Body", with: "Need less chocolate"
      click_on "Update Goal"
    end

    it "redirects to goal show page" do
      expect(page).to have_content("Chocolate")
      expect(page).to have_content("Need less chocolate")
    end


  end
end

feature "deleting goals" do
  before(:each) do
    sign_in_user
    submit_goal
    click_on "Delete Goal"
  end

  it "redirects to the goal index page" do
    expect(page).to have_content("All Goals")
  end

  it "deleted the goal" do
    expect(page).to_not have_content("Chocolate")
  end
end

feature "completing goals" do
  before(:each) do
    sign_in_user
    submit_goal
    visit '/goals'
  end

  it "allows user to complete a goal" do
    expect(page).to have_content("Completed?")
  end

  it "allows users to complete" do
    check('Completed?')
    click_on "Good for you!"
    expect(page).to have_content("COMPLETED!!!!!!!!!!!!")
  end
end
