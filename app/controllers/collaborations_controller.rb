class CollaborationsController < ApplicationController

  before_filter :check_developer_details, :only => :create

  def create
    project = Project.find(params[:project_id])
    collaboration = project.collaborations.create(:developer_id => current_user.id)

    flash[:notice] = "Your request to join the project has been sent"
    redirect_to dashboard_path(current_user)
  end

  def assign
    collaboration = Collaboration.find(params[:id])
    project = Project.find(params[:project_id])

    project.assign!(collaboration)

    redirect_to user_path(current_user)
  end

  def check_developer_details
    if current_user.missing_details?
      flash[:notice] = "Your account is missing some details, please #{view_context.link_to 'fill them in before', edit_developer_path(current_user)} joining this project"
      redirect_to project_path(project) and return
    end
  end

end
