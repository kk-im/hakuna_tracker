class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @project = Project.new
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save!
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :deadline, :expected_time, :rate)
  end
end
