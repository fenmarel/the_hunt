class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if not @user.confirms_password(password_params)
      flash.now[:errors] = ["password and confirmation do not match"]
      render :new
    elsif @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new

    render :new
  end

  def rejections
    @user = User.find(params[:id])
    @job_applications = @user.rejections

    render :rejections
  end

  def show
    @user = User.find(params[:id])
    @job_application = JobApplication.new
    @job_applications = @user.pending_applications

    render :show
  end







  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def password_params
    params[:user][:password_confirmation]
  end
end