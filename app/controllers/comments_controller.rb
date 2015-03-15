class CommentsController < ApplicationController
  before_action :find_task

  def create
    comment = Comment.new(comment_params.merge(:task_id => @task.id, :user_id => current_user.id))
    project_id = @task.project_id
    comment.save
    redirect_to project_task_path(project_id, @task)
  end

  private

  def find_task
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :task_id, :user_id)
  end

end
