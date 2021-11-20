class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      @new_project = Project.new
      @projects = Project.where("user_id = ? AND completed = ? AND deadline > ?", current_user.id, false, (Date.today + 7)).order(deadline: :desc)
      @timelapse = Timelapse.new
      @projects_recently_completed = Project.where(user: current_user, completed: true).order(deadline: :desc).limit(5)
    end
  end

  def all_projects
    if user_signed_in?
      @new_project = Project.new
      @projects = Project.all
    end
  end

  def completed_projects
    @new_project = Project.new
    @projects_recently_completed = Project.where(user: current_user, completed: true).order(updated_at: :desc)
  end
end
