class MembershipsController < ApplicationController

  before_action :find_project
  before_action :project_member
  before_action :project_owner, only: [:edit, :update]

  def index
    @membership = Membership.new
    @memberships = @project.memberships.all.order(:role)
  end

  def create
    @membership = @project.memberships.new(membership_params)

    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      @memberships = @project.memberships.all.order(:role)
      render 'index'
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])

    if @membership.role == "owner" && @project.memberships.where(role: "owner").count == 1
      flash[:error] = "Projects must have at least one owner"
    else
      @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
    end
    redirect_to project_memberships_path(@project)
  end

  def destroy
    membership = @project.memberships.find(params[:id])

    if membership.role == "owner" && @project.memberships.where(role: "owner").count == 1
      flash[:error] = "Projects must have at least one owner"
    elsif current_user.is_project_owner(@project) || current_user.id == membership.user_id
      membership.destroy
      flash[:notice] = "#{membership.user.full_name} was successfully removed"
    end
    redirect_user
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

  def redirect_user
    if flash[:error]
      redirect_to project_memberships_path
    else
      redirect_to projects_path
    end
  end

end
