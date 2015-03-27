class MembershipsController <ApplicationController

  before_action :find_project
  before_action :find_user
  before_action :project_member
  before_action :project_owner, only: [:update, :edit]
  before_action :last_project_owner, only: [:update, :destroy]

  def index
    @membership = Membership.new
    @memberships = @project.memberships.all.order(:role)

  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      @user = @membership.user.full_name
      flash[:notice] = "#{@user} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      @memberships = @project.memberships.all.order(:role)
      render 'index'
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      @user = @membership.user.full_name
      flash[:notice] = "#{@user} was successfully updated"
      redirect_to project_memberships_path(@project)
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    @user = membership.user.full_name
    flash[:notice] = "#{@user} was successfully removed"
    if current_user.is_project_owner(@project)
      redirect_to project_memberships_path(@project)
    else
      redirect_to projects_path
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_user
    @user = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end
end
