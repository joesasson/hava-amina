class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @topics = current_user.topics
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to user_topics_path(current_user)
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @insight = Insight.new
  end

  private

  def topic_params
    params.require(:topic).permit(:name)
  end
end
