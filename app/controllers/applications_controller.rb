class ApplicationsController < ApplicationController
  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to confirmation_applications_path }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, error: 'Please fix the following issues with your application!'  }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirmation
  end

  private
  def application_params
    params.require(:application).permit(:username, :email, :level, :about, :thlevel)
  end
end
