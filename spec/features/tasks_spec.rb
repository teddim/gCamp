require 'rails_helper'

feature 'Tasks CRUD Happy Path-' do

  before(:each) do
    login
  end

  scenario 'CREATE: User can create a new task' do
    visit project_tasks_path
    click_on 'New Task'
    fill_in 'Description', with: 'My task for today'
    fill_in 'Due date', with: '25/03/2015'
    click_on 'Create Task'
    expect(page).to have_content('My task for today')
    expect(page).to have_content('3/25/2015')
    expect(page).to have_content('Task was successfully created')
  end

  scenario 'READ: User can see a task on the index page' do
    task = create_task
    visit project_tasks_path
    expect(page).to have_content('My task for today')
    expect(page).to have_content('3/03/2015')
    expect(find_link('Edit')[:href]).to eq(edit_project_task_path(task))
    expect(find_link('Delete')[:href]).to eq(project_task_path(task))
  end

  scenario 'READ: User can view a single task on the show page' do
    create_task
    visit project_tasks_path
    click_on 'My task for today'
    expect(page).to have_content('My task for today')
    expect(page).to have_content('3/03/2015')
  end

  scenario 'UPDATE: User can update a task' do
    create_task
    visit project_tasks_path
    click_on 'Edit'
    fill_in 'Description', with: 'My edited task'
    fill_in 'Due date', with: '25/03/2015'
    click_on 'Update'
    expect(page).to have_content('My edited task')
    expect(page).to have_content('3/25/2015')
  end

  scenario 'DELETE: User can delete a task' do
    create_task
    visit project_tasks_path
    click_on 'Delete'
    expect(page).to have_no_content('My task for today')
    expect(page).to have_no_content('03/03/2015')
    expect(page).to have_content('Task was successfully deleted')
  end
end

feature "Tasks CRUD validation:" do

  scenario 'User can\'t create a new task without a description' do
    login
    visit project_tasks_path
    click_on 'New Task'
    click_on 'Create Task'
    expect(page).to have_content(/prohibited this form from being saved/)
    click_on 'Cancel'
    expect(current_path).to eq project_tasks_path

  end

  scenario 'User can\'t update a task to have an empty description' do
    create_task
    login
    visit project_tasks_path
    click_on 'Edit'
    fill_in 'Description', with: ''
    click_on 'Update Task'
    expect(page).to have_content(/prohibited this form from being saved/)
    click_on 'Cancel'
    expect(current_path).to eq project_tasks_path
    expect(page).to have_content('My task for today')
  end
end
