require "rails_helper"

RSpec.feature "Listing exercises", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario "With existing exercises" do
    @exercise = create(:exercise, user: @user)
    @second_exercise = create(:exercise, user: @user)
    @third_exercise = create(:exercise, user: @user, created_at: 7.days.ago)

    visit "/"
    click_link "My Lounge"

    expect(page).to have_content(@exercise.workout)
    expect(page).to have_content(@exercise.duration_in_min)
    expect(page).to have_content(@exercise.created_at.to_date)
    expect(page).to have_content(@second_exercise.workout)
    expect(page).to have_content(@second_exercise.duration_in_min)
    expect(page).to have_content(@second_exercise.created_at.to_date)
    expect(page).to_not have_content(@third_exercise.workout)
    expect(page).to_not have_content(@third_exercise.duration_in_min)
    expect(page).to_not have_content(@third_exercise.created_at.to_date)
  end

  scenario "With no exercises" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content("There are no workouts do display")
  end
end
