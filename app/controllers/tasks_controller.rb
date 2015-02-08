class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save
    flash[:notice] = "Task was successfully created."
    redirect_to tasks_path
    # , {:notice => "You have successfully created it."}
  end

  def edit
    @task = Task.find(params[:id])

  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated."
      @referrer = request.referrer
      puts @referrer
      redirect_to task_path
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
    params.require(:task).permit(:description)
  end
end
