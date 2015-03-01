class UsersController < ApplicationController

  def index
    @users = User.all
    @users = @users.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "User was successfully created"
      redirect_to users_path(user)
    else
      @user = user
      render :new
    end
  end

  def show
      @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to users_path
    else
      @user = user
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "User was successfully deleted"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
