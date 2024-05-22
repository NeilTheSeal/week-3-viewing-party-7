require "rails_helper"

RSpec.describe "Viewing Party" do
  before :each do
    @user = User.create!(
      name: "Neil",
      email: "neil@neil.com",
      password: "password",
      password_confirmation: "password"
    )

    @movie = Movie.create!(
      title: "Movie 1 Title",
      rating: 5,
      description: "This is a description about Movie 1"
    )
  end

  it "does not allow unauthorized access to viewing party new page" do
    visit "/users/#{@user.id}/movies/#{@movie.id}"

    click_button "Create a Viewing Party"

    expect(page).to have_current_path("/users/#{@user.id}/movies/#{@movie.id}")

    expect(page).to have_content(
      "You must be logged in or registered to create a Viewing Party."
    )
  end

  it "allows authorized creation of a viewing party" do
    visit root_path

    click_link "Log In"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Log In"

    visit "/users/#{@user.id}/movies/#{@movie.id}"

    click_button "Create a Viewing Party"

    expect(page).to have_current_path(
      "/users/#{@user.id}/movies/#{@movie.id}/viewing_parties/new"
    )

    fill_in :title, with: @movie.title
    fill_in :duration, with: 120
    fill_in :date, with: "2021-08-01"
    fill_in :time, with: "18:00"

    click_button "Create Viewing Party"

    expect(page).to have_current_path(
      user_path(@user)
    )
  end
end
