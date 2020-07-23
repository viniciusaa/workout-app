require "rails_helper"

RSpec.feature "Search for exercises", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    @exercise = create(:exercise, user: @user, workout: "first test")
    @second_exercise = create(:exercise, user: @user, workout: "second test")
  end

  scenario "With multiple results" do
    visit "/"
    click_link "My Lounge"

    fill_in "search", with: "test"
    click_button "Search"

    expect(page).to have_content(@exercise.workout).twice
    expect(page).to have_content(@second_exercise.workout).twice
  end

  scenario "With single result" do
    visit "/"
    click_link "My Lounge"

    fill_in "search", with: "first"
    click_button "Search"

    expect(page).to have_content(@exercise.workout).twice
    expect(page).not_to have_content(@second_exercise.workout).twice
  end

  scenario "With no results" do
    visit "/"
    click_link "My Lounge"

    fill_in "search", with: "aaa"
    click_button "Search"

    expect(page).to have_content("Exercise not found!")
  end
end
