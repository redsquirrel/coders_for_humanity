class DevelopersController < ApplicationController

  def index
    @developers = Developer.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = Developer.find(params[:id])
    @user.update_attributes(params[@user])
    @user.account.update_attributes(params[:account])

    redirect_to developer_path
  end

  def dashboard
    @projects = current_user.projects
    @feedbacks = current_user.received_feedbacks

    if current_user.missing_details?
      flash[:notice] = "Your account is missing some details, please #{view_context.link_to 'edit', edit_developer_path(current_user)} your profile"
    end
  end
end
