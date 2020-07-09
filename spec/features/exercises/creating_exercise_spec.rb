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
    expect(current_path).to eq(user_exercise_path(@user, exercise.last))

  end
end
