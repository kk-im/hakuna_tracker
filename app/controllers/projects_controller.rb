class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save!
      redirect_to root_path
    else
      render "new"
    end
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @status = @project.completed ? "Complete" : "Incomplete"
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate)
  end
end
