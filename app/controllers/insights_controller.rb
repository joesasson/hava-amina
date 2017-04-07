class InsightsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    unless current_user.id == @topic.user_id
      flash[:alert] = "You can only edit your own topics"
      redirect_to root_path and return
    end
    @insight = Insight.new(insight_params)
    @insight.topic = @topic
    if @insight.save
      flash[:notice] = "Added Insight"
      redirect_to topic_path(@insight.topic)
    else
      flash[:alert] = "There was a problem with the insight"
      topic_path(@insight.topic)
    end
  end

  private

  def insight_params
    params.require(:insight).permit(:text)
  end
end
