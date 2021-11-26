require 'json'
require 'open-uri'
class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.priority = current_user.projects.count + 1
    redirect_to root_path if @project.save!
    # else
    #   render "new"
    # end
  end

  # def sort
  #   params["oldPriority"]
  #   params["newPriority"]
  #   params["elementId"]
  # end

  def index
    @projects = Project.where(user: current_user)
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
      UserMailer.welcome
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    # raise
    @project = Project.find(params[:id])
    @project.update(project_params)
    # redirect_to project_path(@project)
    redirect_to(params[:return_to] + "#project-#{@project.id}")
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
      @clients = Project.where(user: current_user, client: params[:query]).select(:client).group(:client).count
    else
      @clients = Project.where(user: current_user).select(:client).group(:client).count
    end
  end

  def client_projects
    @new_project = Project.new
    @client_projects = Project.where(user: current_user)
    @projects_of_client = @client_projects.select { |project| project.client == params[:client] }
  end

  def invoices
    @new_project = Project.new
    @projects = Project.where(user: current_user, completed: true)
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate)
  end
end
