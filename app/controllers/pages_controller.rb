class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @project = Project.new
    @projects = Project.where(user: current_user)
  end

  def clients
    @clients = Project.where(user: current_user).select(:client).group(:client)
  end

end
