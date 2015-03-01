require 'rails_helper'

feature 'Tasks' do

  scenario 'User can see a task on the index page' do
    Task.create!(
      description: 'My new task',
      due_date: 20150303
    )
    visit tasks_path
    expect(page).to have_content('My new task')
    expect(page).to have_content('03/03/2015')
  end

  scenario 'User can create a new task' do
    visit tasks_path
    click_on 'New Task'
    fill_in 'Description', with: 'My new task'
    fill_in 'Due date', with: ('03/03/2015')
    click_on 'Create Task'
    expect(page).to have_content('My new task')
    expect(page).to have_content('03/03/2015')
    expect(page).to have_content('Task was successfully created')
  end

  scenario 'User can\'t create a new task without a description' do
    visit tasks_path
    click_on 'New Task'
    fill_in 'Due date', with: ('03/03/2015')
    click_on 'Create Task'
    expect(page).to have_content(/error prohibited this form from being saved/)

  end

  scenario 'User can view a single task' do
    Task.create!(
      description: 'My new task',
      due_date: 20150303
    )
    visit tasks_path
    click_on 'My new task'
    expect(page).to have_content('My new task')
    expect(page).to have_content('03/03/2015')
  end

  scenario 'User can update a task' do
    Task.create!(
      description: 'My new task',
      due_date: 20150303
    )
    visit tasks_path
    click_on 'Edit'
    fill_in 'Description', with: 'My edited task'
    fill_in 'Due date', with: '25/03/2015'
    click_on 'Update'
    expect(page).to have_content('My edited task')
    expect(page).to have_content('03/25/2015')
  end

  scenario 'User can delete a task' do
    Task.create!(
      description: 'My new task',
      due_date: 20150303
    )
    visit tasks_path
    click_on 'Delete'
    expect(page).to have_no_content('My new task')
    expect(page).to have_no_content('03/03/2015')
    expect(page).to have_content('Task was successfully deleted')
  end

end
