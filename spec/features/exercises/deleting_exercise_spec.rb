require "rails_helper"

RSpec.feature "Deleting exercise", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    @exercise = create(:exercise, user: @user)
  end

  scenario "Deleting exercise" do
    visit "/"
    click_link "My Lounge"
    click_link "Delete"

    expect(page).to have_content("Exercise was successfully deleted")
    expect(page).to have_content("There are no exercises do display")
  end
end
