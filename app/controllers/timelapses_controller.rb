class TimelapsesController < ApplicationController
  def create
    raise
    @timelapse = Timelapse.new
    @project = Project.find(params[:project_id])
    @timelapse.project = @project
    @timelapse.start_time = Time.now
    @timelapse.save
  end

  def update
    @timelapse = Timelapse.find(params[:id])
    @timelapse.description = params[:description] if params[:description]
    @timelapse.end_time = Time.now
    @timelapse.duration = @timelapse.end_time - @timelapse.start_time
    @timelapse.save
    @timelapse.project.cost += @timelapse.duration / 60 * @timelapse.project.rate
  end
end

# rails console commands to test update action
# User.create!(email: "test2@test.com", password: "123456")
# Project.create!(user: User.last, name: "Special feature", client: "Julio", rate: 8)
# Timelapse.create!(project: Project.last, start_time: Time.now)
# tl = Timelapse.last
# tl.end_time = Time.now
# tl.duration = tl.end_time - tl.start_time
# tl.project.cost = tl.duration * tl.project.rate
