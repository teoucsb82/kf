class ForumsController < ApplicationController
  before_filter :authenticate_user!  
  before_filter :load_forum, only: [:show]

  def index
    @forums = Forum.all
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = current_user.forums.new(forum_params)

    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new, error: 'Please fix the following issues with your forum!'  }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if @forum.slug == "application-review"
      Application.all.each do |application|
        @forum.topics.create(:title => application.username, description: application.about) unless @forum.topics.map(&:title).include?(application.username)
      end
      render :application_review
    end
  end

  private
  def forum_params
    params.require(:forum).permit(:title, :description, :user_id)
  end

  def load_forum
    @forum = Forum.find(params[:id])
  end
end
