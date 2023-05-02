class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
