require "rails_helper"

RSpec.feature "Unfollowing friends", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @following = Friendship.create(user: @user, friend: @second_user)

    login_as(@user)
  end

  scenario "if signed in" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content(@second_user.full_name)
    click_link("unfollow")

    expect(page).to have_content(@second_user.full_name + " unfollowed")
  end
end
