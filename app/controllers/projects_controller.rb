class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @status = @project.completed ? "Complete" : "Incomplete"
  end

  # pseudo
  def edit
    @project = Project.find(params[:id])
  end

  # pseudo
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

  # pseudo
  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate)
  end
end
