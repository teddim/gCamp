require 'rails_helper'


feature 'Users CRUD Happy Path-' do

  before(:each) do
    login
  end

  scenario 'CREATE: User can create a new user' do
    visit users_path
    click_on 'New User'
    fill_in 'First name', with: 'Tester2'
    fill_in 'Last name', with: 'Test2'
    fill_in 'Email', with: 't@t2.com'
    fill_in 'Password', with: 'test'
    fill_in 'Password confirmation', with: 'test'
    fill_in 'Pivotal Tracker Token', with: 'pivotal token'

    click_on 'Create User'
    expect(page).to have_content('Tester2')
    expect(page).to have_content('Test2')
    expect(page).to have_content('t@t2.com')
  end

  scenario 'READ: User can see a user on the index page' do
    visit users_path
    expect(page).to have_content('Tester')
    expect(page).to have_content('Test')
    expect(page).to have_content('t17@t.com')
  end

  scenario 'READ: User can view a single user on the show page' do
    create_user(first_name: 'Another',email:'t2@t.com')
    visit users_path
    click_on 'Another'

    # within(".h1.page-header") do
    #   expect(page).to have_content('Tester Test')
    # end
    expect(page).to have_content('Another')
    expect(page).to have_content('Test')
    expect(page).to have_content('t2@t.com')
  end

  scenario 'UPDATE: User can update a user' do
    visit users_path
    click_on 'Edit'
    fill_in 'First name', with: 'My edited user'
    fill_in 'Last name', with: 'Apple'
    fill_in 'Email', with: 't3@t.com'
    click_on 'Update'
    expect(page).to have_content('My edited user')
    expect(page).to have_content('Apple')
    expect(page).to have_content('t3@t.com')
  end

  scenario 'DELETE: User can delete a user' do
    user = create_user(first_name: 'Another', last_name: 'One', email:'t2@t.com', admin: true, pivotal_token: "pivotal token")
    visit edit_user_path(user)
    click_on 'Delete'
    expect(page).to have_no_content('Another')
    expect(page).to have_no_content('One')
    expect(page).to have_no_content('t2@t.com')
    expect(page).to have_content('User was successfully deleted')
  end
end

feature "Users CRUD validation:" do

  scenario 'User can\'t create a new user without entering required data' do
    login
    visit users_path
    click_on 'New User'
    click_on 'Create User'
    expect(page).to have_content(/prohibited this form from being saved/)
  end
end
