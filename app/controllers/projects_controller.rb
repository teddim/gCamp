class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :update, :destroy, :edit]
  before_action :project_member, only: [:show, :update, :destroy, :edit]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @membership = Membership.new
    @page_name = "New"
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @membership = Membership.new(role: "owner", project_id: @project.id, user_id: current_user.id)
      @membership.save
      flash[:notice] = "Project was successfully created"
      redirect_to project_tasks_path(@project)
    else
      @page_name = "New"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @page_name = "Edit"
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to project_path(@project)
    else
      @page_name = "Edit"
      render :edit
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end
end
