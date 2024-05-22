require "rails_helper"

RSpec.describe "Sessions", type: :feature do
  before(:each) do
    @user = User.create!(
      email: "neil@neil.com",
      name: "Neil",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "sets the session to remain logged in" do
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log In"

    visit "https://www.google.com"

    visit "/"

    expect(page).to have_content("Logged in as Neil")
  end

  it "can log out a session" do
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log In"

    click_on "Log Out"

    expect(page).to_not have_content("Logged in as Neil")
  end
end
