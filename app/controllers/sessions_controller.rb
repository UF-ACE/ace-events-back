class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: auth_hash['info']['email']) || User.create_with_omniauth!(auth_hash)
    reset_session
    session[:user_id] = @user.id
  end

  def destroy
    reset_session
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end