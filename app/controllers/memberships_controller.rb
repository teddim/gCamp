class MembershipsController <ApplicationController

  before_action :authenticate_user
  before_action :find_project

  def index
    @memberships = @project.memberships

  end

  # def new
  #
  # end
  #
  # def create
  #
  # end
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

  def membership_params
    params.require(:membership).permit(:role)
  end
end
