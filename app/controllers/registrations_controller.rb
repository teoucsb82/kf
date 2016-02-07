class RegistrationsController < Devise::RegistrationsController
 
  def new
    build_resource({})
    respond_with self.resource
  end
 
  def create
    unless params[:user][:secret_phrase] == "#bestclanever"
      return redirect_to new_user_registration_path, alert: 'Incorrect secret phrase'
    end
    super
  end
 
  private
 
  def sign_up_params
    allow = [:email, :password, :password_confirmation, :username, :secret_phrase]
    params.require(resource_name).permit(allow)
  end
 
end
