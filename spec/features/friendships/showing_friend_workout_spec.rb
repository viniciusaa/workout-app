require "rails_helper"

RSpec.feature "Showing friend workout", :type => :feature do
  before do
    @user = create(:user)
    @exercise = create(:exercise, user: @user)

    @second_user = create(:user)
    @second_exercise = create(:exercise, user: @second_user)

    @following = Friendship.create(user: @user, friend: @second_user)

    login_as(@user)
  end

  scenario "Show friends workout for last 7 days" do
    visit "/"
    click_link "My Lounge"
    click_link @second_user.full_name

    expect(page).to have_content(@second_user.full_name + "'s Exercises")
    expect(page).to have_content(@second_exercise.workout)
  end
end
