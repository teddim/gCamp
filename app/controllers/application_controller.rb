class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :authenticate_user

  before_action :authenticate_user

  def current_user
    User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if current_user
    else
      flash[:error] = "You must sign in"
      redirect_to signin_path
    end
  end

end
