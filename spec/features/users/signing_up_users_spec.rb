require "rails_helper"

RSpec.feature "Sign Up", :type => :feature do
  before do
    visit "/"
    click_link "Signup"
  end
  
  scenario "Whit valid credentials" do
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "Whit invalid credentials" do
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end
