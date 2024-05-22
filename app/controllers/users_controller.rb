class UsersController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:error] =
        "You must be logged in or registered to access a user's dashboard"
      redirect_to root_path
    end
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      cookies[:location] = params[:location] if params[:location] != ""
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout_user
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
