require "rails_helper"

RSpec.describe "User login" do
  before(:each) do
    @user = User.create(
      name: "User One",
      email: "notunique@example.com",
      password: "password4"
    )
  end

  it "logs in successfully with correct password" do
    visit root_path

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{@user.name}")
  end

  it "does not log in successfully with wrong password" do
    visit root_path

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: @user.email
    fill_in :password, with: "incorrect_password"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "does not log in successfully with invalid email" do
    visit root_path

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: "invalid@email.com"
    fill_in :password, with: @user.password

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
