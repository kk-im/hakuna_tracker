require 'json'
require 'open-uri'
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
    @new_project = Project.new
    @project = Project.find(params[:id])
    @status = @project.completed ? "Complete" : "Incomplete"
    @counter = 1
    @logs = @project.timelapses

    url = 'https://api.imgflip.com/get_memes'
    memes_url = URI.open(url).read
    @memes = JSON.parse(memes_url)
    @meme_hash = @memes['data']['memes'].sample
    @image_meme = @meme_hash['url']

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@project.name}", template: "projects/pdf.html.erb"   # Excluding ".pdf" extension.
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
    @project.update(completed: true)
    flash[:notice] = "The task has been completed"
    redirect_to project_path(@project)
  end

  def clients
    @new_project = Project.new
    if params[:query].present?
      @clients = Project.where("user_id = ? AND client @@ ?", current_user.id, params[:query]).select(:client).group(:client).count
    else
      @clients = Project.where(user: current_user).select(:client).group(:client).count
    end
  end

  def client_projects
    @new_project = Project.new
    @client_projects = Project.where(user: current_user)
    @projects_of_client = @client_projects.select { |project| project.client == params[:client] }
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate)
  end
end
