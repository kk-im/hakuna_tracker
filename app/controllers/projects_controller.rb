require 'json'
require 'open-uri'
class ProjectsController < ApplicationController

  def sort
    @project = Project.find(params[:id])
    @project.insert_at(params[:position].to_i)
  end

  def index
    @projects = Project.where(user: current_user)
  end

  def show
    if params[:timelapse_id].present?
      @timelapse = Timelapse.find(params[:timelapse_id])
    else
      @timelapse = Timelapse.new
    end
    @new_project = Project.new
    @project = Project.find(params[:id])
    @toogle_complete = @project.completed ? "Mark as incomplete" : "Mark as complete"
    @status = @project.completed ? "Complete" : "Incomplete"
    @logs = @project.timelapses.where('duration is not null')
    @total_cost = @logs.sum { |log| (log.duration / 3600) * @project.rate }
    @client_email = @project.email
    @project.user = current_user

    url = 'https://api.imgflip.com/get_memes'
    memes_url = URI.open(url).read
    @memes = JSON.parse(memes_url)
    @meme_hash = @memes['data']['memes'].sample
    @image_meme = @meme_hash['url']

    @logo_url = "http://#{request.host_with_port}/assets/logo.png"

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@project.name}", template: "projects/pdf.html.erb"   # Excluding ".pdf" extension.
      end
    end
  end


  def create
    @project = Project.new(project_params)
    @project.user = current_user
    redirect_to root_path if @project.save!
    # else
    #   render "new"
    # end
  end

  def send_email
    @project = Project.find(params[:id])
    ProjectMailer.with(project: @project).project_invoice_email.deliver_now
    flash[:notice] = "Email sent correctly"
    redirect_to project_path(@project)
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    # raise
    # byebug
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

  def toogle_complete
    @project = Project.find(params[:id])
    if @project.completed
      @project.update(completed: false)
      flash[:notice] = "The task isn't completed"
    else
      @project.update(completed: true)
      flash[:notice] = "The task has been completed"
    end
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

  def reports
    invoices
    @projects_per_costumer = Project.where(user: current_user).group(:client).count
    @billing_per_costumer = Project.where(user: current_user).group(:client).sum(:cost)
    @dates_for_timeline = []
    @projects_for_timeline = Project.where(user: current_user)
    @projects_for_timeline.each do |project|
      @dates_for_timeline << [project.name, project.created_at, project.deadline]
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate, :email)
  end
end
