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
      search_in_all_projects
    end
  end

  def completed_projects
    @new_project = Project.new
    search_completed_projects
  end

  private

  def search_projects_due_soon
    if params[:query].present?
      @projects = Project.where("user_id = ? AND completed = ? AND deadline < ? AND name @@ ?", current_user.id, false, (Date.today + 7), params[:query])
    else
      @projects = Project.where("user_id = ? AND completed = ? AND deadline < ?", current_user.id, false, (Date.today + 7))
    end
  end

  def search_in_all_projects
    if params[:query].present?
      @projects = Project.where("name @@ ?", params[:query])
    else
      @projects = Project.all
    end
  end

  def search_completed_projects
    if params[:query].present?
      @completed_projects = Project.where("user_id = ? AND completed = ? AND name @@ ?", current_user.id, true, params[:query]).order(updated_at: :desc)
    else
      @completed_projects = Project.where(user: current_user, completed: true).order(updated_at: :desc)
    end
  end
end
