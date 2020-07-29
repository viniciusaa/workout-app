require "rails_helper"

RSpec.feature "Listing users", :type => :feature do
  before do
    @user = create(:user, first_name: "First", last_name: "Test")
    @second_user = create(:user, first_name: "Second", last_name: "Test")
    @third_user = create(:user, first_name: "Third", last_name: "Test")
  end

  scenario "Shows a list of registred members" do
    visit "/"

    fill_in "search_name", with: "Test"
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@second_user.full_name)
    expect(page).to have_content(@third_user.full_name)
  end
end
