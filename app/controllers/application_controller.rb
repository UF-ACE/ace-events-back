class ApplicationController < ActionController::API
  def current_user
    User.find_by(id: session[:user_id])
  end

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end
end
