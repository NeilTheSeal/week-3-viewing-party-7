require "rails_helper"

RSpec.describe "User Registration" do
  it "can create a user with a name and unique email" do
    visit register_path

    fill_in :user_name, with: "User One"
    fill_in :user_email, with: "user1@example.com"
    fill_in :user_password, with: "password1"
    fill_in :user_password_confirmation, with: "password1"
    click_button "Create New User"

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end

  it "does not create a user if email isnt unique" do
    User.create(
      name: "User One",
      email: "notunique@example.com",
      password: "password4"
    )

    visit register_path

    fill_in :user_name, with: "User Two"
    fill_in :user_email, with: "notunique@example.com"
    fill_in :user_password, with: "password2"
    fill_in :user_password_confirmation, with: "password2"
    click_button "Create New User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it "must have matching password and password_confirmation" do
    visit register_path

    fill_in :user_name, with: "User Three"
    fill_in :user_email, with: "something@example.com"
    fill_in :user_password, with: "password3"
    fill_in :user_password_confirmation, with: "password2"
    click_button "Create New User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content(
      "Password confirmation doesn't match Password"
    )
  end
end
