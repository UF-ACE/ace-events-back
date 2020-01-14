class SessionsController < ApplicationController
  def create
    @user = User.build_with_omniauth!(auth_hash)
    if @user.save
      reset_session
      session[:user_id] = @user.id
      unless request.env['omniauth.origin'].nil?
        redirect_to request.env['omniauth.origin']
      else
        redirect_to '/'
      end
    else
      render json: {error: @user.errors}, status: :bad_request
    end
  end

  def get
    head :forbidden if session[:user_id].nil?
    @user = User.find_by(id: session[:user_id])
  end

  def destroy
    reset_session
  end

  def failure
    redirect_to '/', :alert => "Authentication error: #{params[:message].humanize}"
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end