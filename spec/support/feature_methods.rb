def login(user = create_user)
  visit signin_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  within("form") do
    click_button 'Sign in'
  end
end

def goto_project_tasks
  @task = create_task
  @project = @task.project
  visit project_tasks_path(@project,@task)
end
