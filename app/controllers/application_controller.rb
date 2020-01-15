class ApplicationController < ActionController::API
  def current_user
    User.find_by(id: session[:user_id])
  end

  rescue_from CanCan::AccessDenied do |exception|
    render file: Rails.root.join('public/403.html'), formats: [:html], status: 403, layout: false
  end
end
