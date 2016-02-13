class MembersController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @articles = Article.recent
  end

  def calendar
  end
end
