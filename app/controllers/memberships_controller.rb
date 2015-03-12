class MembershipsController <ApplicationController

  before_action :authenticate_user
  before_action :find_project
  before_action :find_user

  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      @user = @membership.user.full_name
      flash[:notice] = "#{@user} was successfully added"
      redirect_to project_memberships_path(@project)
    end
  end
  #
  # def edit
  #
  # end
  #
  # def  update
  #
  # end
  #
  # def destroy
  #
  # end

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
