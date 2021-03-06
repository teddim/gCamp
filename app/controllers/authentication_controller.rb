class AuthenticationController < PublicController

  def new
    @user = User.new
  end

  # def create
  #   user = User.find_by_email(params[:email])
  #   if user && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     flash[:notice] = "You have successfully signed in"
  #     if session[:previous_page] == nil
  #       redirect_to projects_path
  #     else
  #       redirect_to session[:previous_page]
  #     end
  #   else
  #     flash[:error] = "Email / Password combination is invalid"
  #     render :new
  #   end
  # end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully signed in"
      redirect_authenticated_user
    else
      flash[:error] = "Email / Password combination is invalid"
      render :new
    end

  end


  def destroy
    session.clear
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end

  def redirect_authenticated_user
    if session[:previous_page] == nil
      redirect_to projects_path
    else
      redirect_to session[:previous_page]
    end
  end
  
end
