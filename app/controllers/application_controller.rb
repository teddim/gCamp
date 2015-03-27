class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :authenticate_user
  helper_method :project_member
  helper_method :project_owner

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

  def project_member
    if !(current_user.is_project_member(@project))
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def project_owner
    if !(current_user.is_project_owner(@project))
      flash[:error] = "You do not have access"
      redirect_to project_path(@project)
    end

  end

  def last_project_owner
    if (current_user.is_last_project_owner(@project))
      flash[:error] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project)
    end
  end

end
