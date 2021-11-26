
class TimelapsesController < ApplicationController
  def create
    @timelapse = Timelapse.new(timelapse_params)
    @project = Project.find(params[:timelapse][:project_id])
    @timelapse.project = @project
    if @timelapse.save
      redirect_to "#{root_path}?timelapse_id=#{@timelapse.id}"
    else
      render 'pages/home'
    end
  end

  def update
    @timelapse = Timelapse.find(params[:id])
    if @timelapse.start_time
      @timelapse.end_time = Time.now
      @timelapse.duration = @timelapse.end_time - @timelapse.start_time
      if @timelapse.project.nil?
        @timelapse.project.update(cost: 0)
        @timelapse.project.reload
      end
      @timelapse.project.cost += @timelapse.duration / 3600 * @timelapse.project.rate
    else
      @timelapse.start_time = Time.now
    end
    @timelapse.description = params[:description] if params[:description]
    @timelapse.save
    redirect_to "#{root_path}?timelapse_id=#{@timelapse.id}"
  end

  private

  def timelapse_params
    params.require(:timelapse).permit(:description)
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
