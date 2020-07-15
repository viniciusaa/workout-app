require "rails_helper"

RSpec.feature "Displaying exercise", :type => :feature do
  before do
    @user = create(:user)
    login_as(@user)
    @exercise = create(:exercise, user: @user)
  end

  scenario "Show exercise" do
    visit "/"
    click_link "My Lounge"
    click_link "Display"

    expect(page).to have_content(@exercise.workout)
    expect(page).to have_content(@exercise.workout_date)
    expect(page).to have_content(@exercise.duration_in_min)
  end
end
