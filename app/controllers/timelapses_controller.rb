class TimelapsesController < ApplicationController
  def create
    @timelapse = Timelapse.new
    @project = Project.find(params[:project_id])
    @timelapse.project = @project
    @timelapse.start_time = Time.now
    @timelapse.save
    # return something for the frontend
  end

  def update
    @timelapse = Timelapse.find(params[:id])
    @timelapse.description = params[:description] if params[:description]
    @timelapse.end_time = Time.now
    @timelapse.duration = @timelapse.end_time - @timelapse.start_time
    @timelapse.save
    # return something for the frontend
  end
end
