class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  
  # protect_from_forgery with: :exception
  # protect_from_forgery unless: -> { request.format.json? }
  ###### before_action :check_login
  helper_method :current_user

  def current_user
    puts session[:id]
    if session[:id]
      @current_user  = User.find(session[:id])
    end
  end
  
  def log_in(user)
    puts user
    puts session[:id]
    session[:id] = user.id
    @current_user = user
    redirect_to root_path
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:id)
    @current_user = nil
  end
end
