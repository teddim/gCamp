class AboutController < PublicController

  def index
    @project_count = Project.all.count
    @task_count = Task.all.count
    @membership_count = Membership.all.count
    @user_count = User.all.count
    @comment_count = Comment.all.count
  end
end
