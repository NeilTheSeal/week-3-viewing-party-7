require "rails_helper"

RSpec.describe "Location", type: :feature do
  before(:each) do
    @user = User.create!(
      email: "neil@neil.com",
      name: "Neil",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "should set the location cookie" do
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    fill_in :location, with: "London"

    click_on "Log In"

    expect(page).to have_current_path("/")
    expect(page).to have_content("Location: London")

    click_on "Log Out"

    expect(page).to have_current_path("/")

    click_on "Log In"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on "Log In"

    expect(page).to have_content("Location: London")
  end
end
