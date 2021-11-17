class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @project = Project.new
      @projects = Project.where("user_id = ? AND completed = ? AND deadline > ?", current_user.id, false, (Date.today + 7))
      @projects_completed = Project.where(user: current_user, completed: true).order(updated_at: :desc).limit(5)
    end
  end

  def all_projects
    if user_signed_in?
      @project = Project.new
      @projects = Project.all
    end

  end
end
