class TasksController < ApplicationController

  respond_to :json

  def create
    task = Project.find(params[:project_id]).tasks.new(task_params.merge(:status => 0, :deadline => Time.now + 2.day))
    if task.save
      render json: task
    else
      render json: { error: task.errors }
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      render json: { success: true }
    else
      render json: { error: task.errors }
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    if task.destroyed?
      render json: { success: true }
    else
      render json: { error: task.errors }
    end
  end

  def position
    Project.find(params[:project_id]).tasks.find(params[:id]).insert_at(params[:position])
    render json: { status: 'success' }
  end


  private

  def task_params
    params.require(:task).permit(:project_id, :name, :position, :status, :deadline)
  end

end
