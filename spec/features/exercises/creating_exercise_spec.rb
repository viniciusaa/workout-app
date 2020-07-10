require "rails_helper"

RSpec.feature "Creating exercise", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario "Whit valid inputs" do
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"

    fill_in "Duration", with: 70
    fill_in "Workout details", with: "Weight lifting"
    fill_in "Activity date", with: "2016-07-26"
    click_button "Create Exercise"

    expect(page).to have_content("Exercise has been created")
    expect(page).to have_content("Weight lifting")
    expect(current_path).to eq(user_exercise_path(@user, Exercise.last))
  end

  scenario "Whit invalid inputs" do
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"

    fill_in "Duration", with: 70
    fill_in "Workout details", with: ""
    fill_in "Activity date", with: ""
    click_button ""

    expect(page).to have_content("Failed to created exercise")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
end
