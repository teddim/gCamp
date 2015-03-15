class TasksController < ApplicationController

  before_action :authenticate_user
  before_action :find_project

  def index
    @tasks = @project.tasks.order(:id)

  end

  def new
    @task = @project.tasks.new
    @page_name = "New Task"
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: "Task was successfully created."
    else
      @page_name = "New Task"
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
    @page_name = "Edit"
  end

  def update
    @task = @project.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated."
      redirect_to project_task_path(@project,@task[:id])
    else
      @page_name = "Edit"
      render :edit
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def destroy
    task = @project.tasks.find(params[:id])
    if task.destroy
      flash[:notice] = "Task was successfully deleted."
      redirect_to project_tasks_path
    end
  end


  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end

end
