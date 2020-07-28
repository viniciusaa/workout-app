require "rails_helper"

RSpec.feature "Listing menbers", :type => :feature do
  before do
    @user = create(:user)
    @second_user = create(:user)
    @third_user = create(:user)
  end

  scenario "Shows a list of registred members" do
    visit "/"

    expect(page).to have_content("List of members")
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@second_user.full_name)
    expect(page).to have_content(@third_user.full_name)
  end
end
