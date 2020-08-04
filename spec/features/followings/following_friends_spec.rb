require "rails_helper"

RSpec.feature "Following friends", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)

    login_as(@user)
  end

  scenario "if signed in" do
    visit "/"

    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@second_user.full_name)
    expect(page).not_to have_link("Follow", :href => "/friendships?friend_id=#{@user.id}")
    expect(page).to have_link("Follow", :href => "/friendships?friend_id=#{@second_user.id}")
    find("a[href='/friendships?friend_id=#{@second_user.id}']").click
    
    expect(page).not_to have_link("Follow", :href => "/friendships?friend_id=#{@second_user.id}")
  end
end
