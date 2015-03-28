class UsersController < ApplicationController

  def index
    @users = User.all
    @users = @users.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to users_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

  end

  def edit
    @user = User.find(params[:id])

    unless @user == current_user || current_user.is_admin
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.comments.each do |comment|
      @user.set_comment_user_id_to_nil(comment)
    end
    if @user = current_user
      session.clear
      where_to_redirect = root_path
    else
      where_to_redirect = users_path
    end
    if @user.destroy
      flash[:notice] = "User was successfully deleted"
      redirect_to where_to_redirect
    end
  end

  private


  def user_params
    if current_user.is_admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:admin, :pivotal_token)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :pivotal_token)
    end
  end

end
