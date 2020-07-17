require "rails_helper"

RSpec.feature "Editing exercise", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    @exercise = create(:exercise, user: @user)

    visit "/"
    click_link "My Lounge"
    click_link "Edit"
  end

  scenario "With valid inputs" do
    fill_in "Duration", with: 70
    fill_in "Workout", with: "Updated Exercise"
    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content("Updated Exercise")
    expect(current_path).to eq(user_exercise_path(@user, Exercise.last))
  end

  scenario "With invalid inputs" do
    fill_in "Duration", with: ""
    fill_in "Workout", with: ""
    click_button "Update Exercise"

    expect(page).to have_content("Failed to update exercise")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout can't be blank")
    expect(page).to have_content("Workout is too short (minimum is 3 characters)")
  end
end
