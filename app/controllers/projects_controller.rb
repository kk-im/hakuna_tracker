class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    redirect_to root_path if @project.save!
    # else
    #   render "new"
    # end
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @status = @project.completed ? "Complete" : "Incomplete"

    @counter = 1
    @logs = @project.timelapses

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "projects/pdf.html.erb"   # Excluding ".pdf" extension.
      end
    end
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
    redirect_to root_path
  end

  def complete
    @project = Project.find(params[:id])
    @project.completed = true
    flash[:notice] = "The task has been completed"
    redirect_to project_path(@project)
  end

  def clients
    @project = Project.new
    @clients = Project.where(user: current_user).select(:client).group(:client).count
  end

  def client_projects
    @client = 0
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate)
  end
end
