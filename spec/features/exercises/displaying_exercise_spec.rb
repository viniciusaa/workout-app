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
    expect(page).to have_content(@exercise.duration_in_min)
    expect(page).to have_content(@exercise.created_at.to_date)
  end
end
