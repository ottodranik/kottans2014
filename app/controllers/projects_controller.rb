class ProjectsController < ApplicationController

  respond_to :json

  def index
    @projects ||= current_user.projects.includes(:tasks)
  end

  def create
    project = Project.new(project_params.merge(:user_id => current_user.id, :name => "Project #{params['project']['position']}"))
    if project.save
      render json: project
    else
      render json: project.errors
    end
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      render json: { success: true }
    else
      render json: { error: project.errors }
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    if project.destroyed?
      render json: { success: true }
    else
      render json: { error: project.errors }
    end
  end

  def position
    Project.find(params[:id]).insert_at(params[:position])
    render json: { status: 'success' }
  end


  private

  def project_params
    params.require(:project).permit(:tasks, :name, :position)
  end

end
