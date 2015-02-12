class TasksController < ApplicationController

  def index
    @tasks = Task.all
    @tasks = @tasks.order(:id)
  end

  def new
    @task = Task.new
    @page_name = "New"
  end

  def create
    task = Task.new(task_params)
    task.save
    flash[:notice] = "Task was successfully created."
    redirect_to task_path(task)
    # , {:notice => "You have successfully created it."}
  end

  def edit
    @task = Task.find(params[:id])
    @page_name = "Edit"
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated."
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    task = Task.find(params[:id])
    task.delete
    redirect_to tasks_path
  end


  private

  def task_params
    params.require(:task).permit(:description, :completed)
  end

end
