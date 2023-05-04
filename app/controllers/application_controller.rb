class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false 
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
