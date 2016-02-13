class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :update, :destroy]
  before_filter :find_forum

  def show
  end

  def new
    @topic = @forum.topics.new
  end

  def create
    @topic = @forum.topics.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
