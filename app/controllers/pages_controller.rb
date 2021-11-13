class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @project = Project.new
    @projects = Project.where(user: current_user)
    @projects_completed = Project.where(user: current_user, completed: true).order(updated_at: :desc).limit(5)
  end
end
