require 'rails_helper'

feature 'Projects CRUD Happy Path-' do

  before(:each) do
    login
  end

  scenario 'CREATE: User can create a new project' do
    visit projects_path
    click_on 'New Project'
    fill_in 'Name', with: 'My project for today'
    click_on 'Create Project'
    expect(page).to have_content('My project for today')
    expect(page).to have_content('Project was successfully created')
  end

  scenario 'READ: User can see a project on the index page' do
    project = create_project
    visit projects_path
    expect(page).to have_content('My project for today')
    expect(find_link('My project for today')[:href]).to eq(project_path(project))
  end

  scenario 'READ: User can view a single project on the show page' do
    project = create_project
    visit project_path(project)
    expect(page).to have_content('My project for today')
    expect(find_link('Edit')[:href]).to eq(edit_project_path(project))
    expect(find_link('Delete')[:href]).to eq(project_path(project))
  end

  scenario 'UPDATE: User can update a project' do
    project = create_project
    visit edit_project_path(project)
    fill_in 'Name', with: 'My edited project'
    click_on 'Update'
    expect(page).to have_content('My edited project')
  end

  scenario 'DELETE: User can delete a project' do
    project = create_project
    visit project_path(project)
    click_on 'Delete'
    expect(page).to have_no_content('My project for today')
    expect(page).to have_content('Project was successfully deleted')
  end
end

feature "Projects CRUD validation:" do

  scenario 'User can\'t create a new project without a name' do
    login
    visit projects_path
    click_on 'New Project'
    click_on 'Create Project'
    expect(page).to have_content(/prohibited this form from being saved/)
    click_on 'Cancel'
    expect(current_path).to eq projects_path

  end

  scenario 'User can\'t update a project to have an empty name' do
    project = create_project
    login
    visit project_path(project)
    click_on 'Edit'
    fill_in 'Name', with: ''
    click_on 'Update Project'
    expect(page).to have_content(/prohibited this form from being saved/)
    click_on 'Cancel'
    expect(current_path).to eq projects_path
    expect(page).to have_content('My project for today')
  end
end
