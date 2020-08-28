require "rails_helper"

RSpec.feature "Sending Message", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @third_user = create(:user)

    @room_name = @user.first_name + "-" + @user.last_name
    @room = Room.create!(name: @room_name, user_id: @user.id)

    login_as(@user)

    Friendship.create(user: @second_user, friend: @user)
    Friendship.create(user: @third_user, friend: @user)
  end

  scenario "to followers shows in chatroom window" do
    visit "/"
    click_link("My Lounge")

    expect(page).to have_content(@room_name)
    fill_in "message_field", with: "Hello"
    click_button "post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@second_user.full_name)
      expect(page).to have_link(@third_user.full_name)
    end
  end
end
