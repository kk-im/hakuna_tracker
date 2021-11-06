class TimelapsesController < ApplicationController

  def new
    @timelapse = Timelapse.new
    @timelapse.start_time = Time.now
    @timelapse.save
  end

  def update
    @timelapse = Timelapse.find[params: 'id']
    @timelapse.description = [params: 'description'] if params['description']
    @timelapse.end_time = Time.now
    @timelapse.update
  end
end
