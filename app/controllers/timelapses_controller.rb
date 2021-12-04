
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
    timelapse_cost = 0
    if @timelapse.start_time
      @timelapse.end_time = Time.now
      @timelapse.duration = @timelapse.end_time - @timelapse.start_time
      if @timelapse.project.cost.nil?
        @timelapse.project.update(cost: 0)
        @timelapse.project.reload
      end
      timelapse_cost = ((@timelapse.duration / 3600) * @timelapse.project.rate).round(2)
      @timelapse.project.update(cost: @timelapse.project.cost + timelapse_cost)
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
