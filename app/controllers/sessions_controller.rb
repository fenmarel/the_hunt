class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["incorrect username or password"]
      render :new
    end
  end

  def destroy
    logout!

    redirect_to new_session_url
  end

  def new
    @user = User.new

    render :new
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end