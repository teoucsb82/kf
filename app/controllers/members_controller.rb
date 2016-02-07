class MembersController < ApplicationController
  before_filter :authenticate_user!  
  def index
  end

  def calendar
  end
end
