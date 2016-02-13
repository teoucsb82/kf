class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || members_path
  end

  def admin_user?
    current_user && (current_user.admin? || (Clan.last.player(current_user.username).present? && Clan.last.player(current_user.username)['role'] == "coLeader"))
  end

  def authenticate_admin!
    authenticate_user! && admin_user?
  end
end
