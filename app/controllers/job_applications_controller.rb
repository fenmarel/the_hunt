class JobApplicationsController < ApplicationController
  before_action :verify_logged_in

  def create
    @job_application = JobApplication.new(full_job_application_params)

    flash[:errors] = @job_application unless @job_application.save

    redirect_to user_url(current_user)
  end

  def denied
    @job_application = JobApplication.find(params[:id])
    @job_application.deny!

    redirect_to rejections_user_url(current_user)
  end

  def destroy
    @job_application = JobApplication.find(params[:id])
    @job_application.destroy

    redirect_to user_url(current_user)
  end

  def edit
    @job_application = JobApplication.find(params[:id])

    render :edit
  end

  def renew
    @job_application = JobApplication.find(params[:id])
    @job_application.renew!

    redirect_to user_url(current_user)
  end

  def update
    @job_application = JobApplication.find(params[:id])

    if @job_application.update(job_application_params)
      redirect_to user_path(current_user)
    else
      flash.now[:errors] = @job_application.errors.full_messages
      render :edit
    end
  end

  private

  def full_job_application_params
    extras = {:user_id => params[:user_id], :application_date => DateTime.now}

    job_application_params.merge(extras)
  end

  def job_application_params
    params.require(:job_application).permit(:job_title, :company, :url)
  end

  def verify_logged_in
    redirect_to new_session_url unless logged_in?
  end
end