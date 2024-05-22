require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  before(:each) do
    @user = User.create!(
      email: "neil@neil.com",
      name: "Neil",
      password: "password",
      password_confirmation: "password"
    )
  end

  it "does not allow unauthorized access to dashboard show page" do
    visit "/users/#{@user.id}"

    expect(page).to have_current_path(root_path)

    expect(page).to have_content(
      "You must be logged in or registered to access a user's dashboard"
    )
  end

  it "allows authorized access to dashboard show page" do
    visit root_path

    click_link "Log In"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Log In"

    visit "/users/#{@user.id}"

    expect(page).to have_current_path("/users/#{@user.id}")
  end
end
